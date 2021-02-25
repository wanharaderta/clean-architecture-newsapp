//
//  FavoriteView.swift
//  NewsApp
//
//  Created by Wanhar on 17/02/21.
//

import SwiftUI
import SwiftUIRefresh

struct FavoriteView: View {
  
  @ObservedObject var presenter: FavoritePresenter
  @State private var articleSelected: ArticleModelOld? = nil
  @State private var isShowing = false
  
  var body: some View {
    ZStack {
      VStack {
        HStack {
          Text("Favorite")
            .font(.largeTitle)
            .fontWeight(.bold)
          Spacer()
        }
        if presenter.isLoading {
          VStack {
            Text("Loading...")
            ActivityIndicator()
          }
        } else {
          List {
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
                ForEach(self.presenter.articles, id: \.id) { item in
//                  ArticleRow(item: item).onTapGesture {
//                    self.articleSelected = item
//                  }
                }
              }.padding(.bottom, 120)
            }
          }.pullToRefresh(isShowing: $isShowing) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
              self.presenter.getFavorite()
              self.isShowing = false
            }
          }
        }
      }.padding()
    }.onAppear {
      if self.presenter.articles.count == 0 {
        self.presenter.getFavorite()
      }
    }
    .sheet(item: $articleSelected) { item in
      self.presenter.linkBuilder(for: item)
    }
    .background(Color.white)
  }
}
