//
//  HomeInteractor.swift
//  NewsApp
//
//  Created by Wanhar on 16/02/21.
//

import Foundation
import Combine

class HomeInteractor: HomeUseCase {
  
  private let repository: ArticlesRepositoryOld
  
  required init(repository: ArticlesRepositoryOld) {
    self.repository = repository
  }
  
  func getArticles() -> AnyPublisher<[ArticleModelOld], Error> {
    return repository.getArticles()
  }
}
