//
//  NewsRepository.swift
//  NewsApp
//
//  Created by Wanhar on 16/02/21.
//

import Foundation
import Combine

protocol ArticlesRepositoryOld: class {
  func getArticles() -> AnyPublisher<[ArticleModelOld], Error>
  func getFavoriteArticles() -> AnyPublisher<[ArticleModelOld], Error>
  func getArticle(by title: String) -> AnyPublisher<ArticleModelOld, Error>
  func addFavoriteArticle(from article: ArticleModelOld) -> AnyPublisher<Bool, Error>
  func removeFavoriteArticle(from article: ArticleModelOld) -> AnyPublisher<Bool, Error>
}
