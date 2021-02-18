//
//  DetailUseCase.swift
//  NewsApp
//
//  Created by Wanhar on 18/02/21.
//

import Combine

protocol DetailUseCase {

  func getArticle() -> ArticleModel
  func getArticle() -> AnyPublisher<ArticleModel, Error>
  func updateFavoriteArticle() -> AnyPublisher<ArticleModel, Error>
}
