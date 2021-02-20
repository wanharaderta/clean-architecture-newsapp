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
  func addFavoriteArticle() -> AnyPublisher<Bool, Error>
  func removeFavoriteArticle() -> AnyPublisher<Bool, Error>
}
