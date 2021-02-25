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
                                                                                  ArticlesLocaleDataSource,
                                                                                  ArticlesRemoteDataSource,
                                                                                  ArticlesTransformer>>>
  @State private var articleSelected: ArticleModel? = nil
  @State private var showingAlert = false
  @State var querySearch = ""
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
          
          HStack(spacing: 15, content: {
            Image(systemName: "magnifyingglass")
              .foregroundColor(Color(.systemGray3))
            TextField("Search for topics, sources", text: $querySearch)
          })
          .padding(10)
          .padding(.horizontal)
          .background(Color(.systemGray6))
          .clipShape(Capsule())
          
          ZStack {
            VStack {
              if presenter.isLoading {
                VStack {
                  Text("Loading...")
                  ActivityIndicator()
                }
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
            .padding(.top, 15)
          }.onAppear {
            if self.presenter.articles.count == 0 {
              self.presenter.getArticles(request: "")
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
