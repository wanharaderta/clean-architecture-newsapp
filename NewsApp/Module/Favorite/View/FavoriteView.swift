//
//  FavoriteView.swift
//  NewsApp
//
//  Created by Wanhar on 17/02/21.
//

import SwiftUI
import SwiftUIRefresh
import Article
import Core

struct FavoriteView: View {
  
  @ObservedObject var presenter: ArticleFavoritePresenter<Interactor<String, [ArticleModel], ArticleFavoriteRepository<
                                                                      ArticlesLocaleDataSourceImpl,
                                                                      ArticlesTransformer>>>
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  @State private var articleSelected: ArticleModel? = nil
  @State private var isShowing = false
  
  var body: some View {
    ZStack {
      VStack {
        if presenter.isLoading {
          VStack {
            Text("Loading...")
            ActivityIndicator()
          }
        } else {
          List {
            HStack {
              Text("Favorite")
                .font(.largeTitle)
                .fontWeight(.bold)
              Spacer()
            }.padding()
            if presenter.articles.count == 0 {
              Spacer()
              HStack {
                Spacer()
                VStack {
                  Image("news")
                    .resizable()
                    .frame(width: 150, height: 150, alignment: .center)
                  Text("Favorite Empty")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding()
                }
                Spacer()
              }
              Spacer()
            } else {
              VStack {
                HStack {
                  Image(systemName: "magnifyingglass")
                    .foregroundColor(Color(.systemGray3))
                  TextField("Search...", text: self.$presenter.searchTemp,
                            onEditingChanged: {_ in } ){ self.presenter.searchArticle() }
                  if self.presenter.searchTemp != "" {
                    Image(systemName: "xmark.circle.fill")
                      .imageScale(.medium)
                      .foregroundColor(Color(.systemGray3))
                      .padding(2)
                      .onTapGesture {
                        withAnimation {
                          self.presenter.searchTemp = ""
                          self.presenter.getFavorites()
                        }
                      }
                  }
                }.padding(12)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .clipShape(Capsule())
                .padding(.vertical, 10)
                
                ForEach(self.presenter.articles, id: \.id) { item in
                  FavoriteRow(item: item).onTapGesture {
                    self.articleSelected = item
                    print("showwwwww \(presentationMode.wrappedValue.isPresented)")
                  }
                }
              }.padding(.bottom, 120)
            }
          }.pullToRefresh(isShowing: $isShowing) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
              self.presenter.getFavorites()
              self.isShowing = false
            }
          }
        }
      }
    }.background(Color.white)
    .sheet(item: $articleSelected) { item in
      self.linkBuilder(for: item, isShowing: isShowing)
    }
    .onAppear {
      self.presenter.getFavorites()
    }
  }
  
  func linkBuilder(
    for article: ArticleModel, isShowing: Bool
  ) -> some View {
    return FavoriteRouter().makeDetailView(for: article)
  }
}
