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
  
  required init(repository: ArticlesRepository,article: ArticleModel) {
    self.repository = repository
    self.article = article
  }
  
  func getArticle() -> ArticleModel {
    return article
  }
}
