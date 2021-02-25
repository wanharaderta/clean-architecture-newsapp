//
//  HomeInteractor.swift
//  NewsApp
//
//  Created by Wanhar on 18/02/21.
//

import Combine

class FavoriteInteractor: FavoriteUseCase {
  
  private let repository: ArticlesRepositoryOld
  
  required init(repository: ArticlesRepositoryOld) {
    self.repository = repository
  }
  
  func getFavoriteArticle() -> AnyPublisher<[ArticleModelOld], Error> {
    return repository.getFavoriteArticles()
  }
}
