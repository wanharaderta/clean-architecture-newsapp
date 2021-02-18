//
//  FavoritePresenter.swift
//  NewsApp
//
//  Created by Wanhar on 18/02/21.
//

import Foundation


class FavoritePresenter: ObservableObject {
  
  @Published var articles: [ArticleModel] = []
  @Published var errorMessage: String = ""
  @Published var isLoading: Bool = false
  
  
  func getFavorite() {
    
  }
  
}
