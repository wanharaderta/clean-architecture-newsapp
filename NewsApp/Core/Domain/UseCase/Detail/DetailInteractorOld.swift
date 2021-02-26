//
//  DetailInteractor.swift
//  NewsApp
//
//  Created by Wanhar on 18/02/21.
//

import Foundation
import Combine

class DetailInteractorOld: DetailUseCaseOld {

  private let repository: ArticlesRepositoryOld
  private let article: ArticleModelOld
  
  required init(repository: ArticlesRepositoryOld, article: ArticleModelOld) {
    self.repository = repository
    self.article = article
  }
  
  func getArticle() -> AnyPublisher<ArticleModelOld, Error> {
    return repository.getArticle(by: article.title)
  }
  
  func getArticle() -> ArticleModelOld {
    return article
  }
  
  func addFavoriteArticle() -> AnyPublisher<Bool, Error> {
    return repository.addFavoriteArticle(from: article)
  }
  
  func removeFavoriteArticle() -> AnyPublisher<Bool, Error> {
    return repository.removeFavoriteArticle(from: article)
  }
}
