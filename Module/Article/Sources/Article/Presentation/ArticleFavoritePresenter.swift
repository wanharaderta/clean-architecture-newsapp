//
//  File.swift
//  
//
//  Created by Wanhar on 26/02/21.
//

import Foundation
import Core
import Combine

public class ArticleFavoritePresenter<FavoritesUseCase: UseCase>: ObservableObject
where FavoritesUseCase.Request == String, FavoritesUseCase.Response == [ArticleModel] {
  
  private var cancellables: Set<AnyCancellable> = []
  
  private let favoritesUseCase: FavoritesUseCase
  
  @Published public var articles: [ArticleModel] = []
  @Published public var articlesTemp: [ArticleModel] = []
  @Published public var searchTemp: String = ""
  @Published public var errorMessage: String = ""
  @Published public var isLoading: Bool = false
  
  public init(favoritesUseCase: FavoritesUseCase) {
    self.favoritesUseCase = favoritesUseCase
  }
  
  public func getFavorites() {
    isLoading = true
    favoritesUseCase.execute(request: "")
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure (let error):
          self.errorMessage = error.localizedDescription
        case .finished:
          self.isLoading = false
        }
      }, receiveValue: { articles in
        self.articles = articles
      }).store(in: &cancellables)
  }
  
  public func searchArticle() {
    isLoading = true
    let filteredArticles =  searchTemp.isEmpty ? self.articlesTemp : self.articles.filter {
      $0.title.localizedCapitalized.contains(searchTemp)
    }
    DispatchQueue.main.async {
      self.articles = filteredArticles
      self.isLoading = false
    }
  }
  
}
