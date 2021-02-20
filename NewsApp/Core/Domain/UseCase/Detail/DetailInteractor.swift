//
//  DetailInteractor.swift
//  NewsApp
//
//  Created by Wanhar on 18/02/21.
//

import Foundation
import Combine

class DetailInteractor: DetailUseCase {

  private let repository: ArticlesRepository
  private let article: ArticleModel
  
  required init(repository: ArticlesRepository, article: ArticleModel) {
    self.repository = repository
    self.article = article
  }
  
  func getArticle() -> AnyPublisher<ArticleModel, Error> {
    return repository.getArticle(by: article.title)
  }
  
  func getArticle() -> ArticleModel {
    return article
  }
  
  func addFavoriteArticle() -> AnyPublisher<Bool, Error> {
    return repository.addFavoriteArticle(from: article)
  }
  
  func removeFavoriteArticle() -> AnyPublisher<Bool, Error> {
    return repository.removeFavoriteArticle(from: article)
  }
}
