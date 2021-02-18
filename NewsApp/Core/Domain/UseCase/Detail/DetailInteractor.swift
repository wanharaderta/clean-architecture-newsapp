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
    print("aaaaa \(repository.getArticle(by: article.id).count())")
    return repository.getArticle(by: article.id)
  }
  func getArticle() -> ArticleModel {
    return article
  }
  func updateFavoriteArticle() -> AnyPublisher<ArticleModel, Error> {
    return re
  }

}
