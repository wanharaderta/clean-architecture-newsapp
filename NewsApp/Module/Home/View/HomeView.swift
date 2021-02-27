//
//  HomeView.swift
//  NewsApp
//
//  Created by Wanhar on 17/02/21.
//

import SwiftUI
import Article
import Core

struct HomeView: View {
  
  @ObservedObject var presenter: ArticlePresenter<Interactor<String, [ArticleModel], ArticlesRepository<
                                                              ArticlesLocaleDataSourceImpl,
                                                              ArticlesRemoteDataSource,
                                                              ArticlesTransformer>>>
  @State private var articleSelected: ArticleModel? = nil
  @State private var showingAlert = false
  
  var body: some View {
    return VStack {
      HStack {
        Button(action: {
          showingAlert.toggle()
        }, label: {
          Image("filter")
            .resizable()
            .renderingMode(.original)
            .frame(width: 24, height: 24)
        })
        
        Spacer(minLength: 0)
        Text(self.presenter.currentDate)
          .font(.body)
          .foregroundColor(.gray)
      }.padding()
      
      ScrollView(.vertical, showsIndicators: false, content: {
        VStack {
          Text("Browse News")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.bottom, 30)
          
          HStack {
            Image(systemName: "magnifyingglass")
              .foregroundColor(Color(.systemGray3))
            TextField("Search for topics, sources", text: self.$presenter.searchTemp,
                      onEditingChanged: {_ in }) { self.presenter.searchArticle() }
            if self.presenter.searchTemp != "" {
              Image(systemName: "xmark.circle.fill")
                .imageScale(.medium)
                .foregroundColor(Color(.systemGray3))
                .padding(2)
                .onTapGesture {
                  withAnimation {
                    self.presenter.searchTemp = ""
                    self.presenter.getArticles()
                  }
                }
            }
          }.padding(12)
          .background(Color(.systemGray6))
          .cornerRadius(10)
          .clipShape(Capsule())
          .padding(.vertical, 10)
          
          ZStack {
            VStack {
              if presenter.isLoading {
                VStack {
                  Text("Loading...")
                  ActivityIndicator()
                }
              } else {
                if self.presenter.articles.isEmpty {
                  Spacer()
                  HStack {
                    Spacer()
                    VStack {
                      Image("news")
                        .resizable()
                        .frame(width: 150, height: 150, alignment: .center)
                      Text("News not available")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding()
                      Button("Refresh") {self.presenter.getArticles()}
                        .padding(7)
                        .foregroundColor(.white)
                        .background(Color.blue.opacity(0.5))
                        .cornerRadius(15)
                        .frame(width: 100)
                       
                    }
                    Spacer()
                  }
                  Spacer()
                } else {
                  VStack {
                    ForEach(self.presenter.articles, id: \.id) { item in
                      ArticleRow(item: item).onTapGesture {
                        self.articleSelected = item
                      }
                    }
                  }.padding(.bottom, 120)
                }
              }
            }
            .padding(.top, 15)
          }.onAppear {
            if self.presenter.articles.isEmpty {
              self.presenter.getArticles()
            }
          }
        }.padding()
      })
    }.sheet(item: $articleSelected) { item in
      self.linkBuilder(for: item)
    }
    .alert(isPresented: $showingAlert) {
      Alert(
        title: Text("Filter"),
        message: Text("Filter not available"),
        dismissButton: .default(Text("OK"))
      )
    }.background(Color.white)
  }
  
  func linkBuilder(
    for article: ArticleModel
  ) -> some View {
    return HomeRouter().makeDetailView(for: article)
  }
}
