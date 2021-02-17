//
//  HomeInteractor.swift
//  NewsApp
//
//  Created by Wanhar on 16/02/21.
//

import Foundation
import Combine

class HomeInteractor: HomeUseCase {
  
  private let repository: ArticlesRepository
  
  required init(repository: ArticlesRepository) {
    self.repository = repository
  }
  
  func getArticles() -> AnyPublisher<[ArticleModel], Error> {
    return repository.getArticles()
  }
}
