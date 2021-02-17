//
//  FavoriteView.swift
//  NewsApp
//
//  Created by Wanhar on 17/02/21.
//

import SwiftUI

struct FavoriteView: View {
  
  @ObservedObject var presenter: FavoritePresenter
  
  var body: some View {
    ZStack {
      ScrollView(.vertical, showsIndicators: false) {
        ZStack {
          VStack {
            if presenter.isLoading {
              VStack {
                Text("Loading...")
                ActivityIndicator()
                
              }
            } else {
              ForEach(self.presenter.articles, id: \.id) { article in
                ArticleRow(item: article).onTapGesture {}
              }
            }
          }
          .padding(.top, 15)
        }
      }
    }.onAppear {
      if self.presenter.articles.count == 0 {
        self.presenter.getFavorite()
      }
    }
  }
}
