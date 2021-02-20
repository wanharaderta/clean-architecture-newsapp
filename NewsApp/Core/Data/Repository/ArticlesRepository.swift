//
//  NewsRepository.swift
//  NewsApp
//
//  Created by Wanhar on 16/02/21.
//

import Foundation
import Combine

protocol ArticlesRepository: class {
  func getArticles() -> AnyPublisher<[ArticleModel], Error>
  func getFavoriteArticles() -> AnyPublisher<[ArticleModel], Error>
  func getArticle(by title: String) -> AnyPublisher<ArticleModel, Error>
  func addFavoriteArticle(from article: ArticleModel) -> AnyPublisher<Bool, Error>
  func removeFavoriteArticle(from article: ArticleModel) -> AnyPublisher<Bool, Error>
}
