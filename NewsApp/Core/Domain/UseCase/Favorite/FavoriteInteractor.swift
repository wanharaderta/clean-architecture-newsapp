//
//  HomeInteractor.swift
//  NewsApp
//
//  Created by Wanhar on 18/02/21.
//

import Combine

class FavoriteInteractor: FavoriteUseCase {
  
  private let repository: ArticlesRepository
  
  required init(repository: ArticlesRepository) {
    self.repository = repository
  }
  
  func getFavoriteArticle() -> AnyPublisher<[ArticleModel], Error> {
    return repository.getFavoriteArticles()
  }
}
