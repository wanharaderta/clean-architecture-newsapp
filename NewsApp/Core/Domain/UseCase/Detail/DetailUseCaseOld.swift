//
//  DetailUseCase.swift
//  NewsApp
//
//  Created by Wanhar on 18/02/21.
//

import Combine

protocol DetailUseCaseOld {

  func getArticle() -> ArticleModelOld
  func getArticle() -> AnyPublisher<ArticleModelOld, Error>
  func addFavoriteArticle() -> AnyPublisher<Bool, Error>
  func removeFavoriteArticle() -> AnyPublisher<Bool, Error>
}
