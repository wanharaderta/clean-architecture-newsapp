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
  func getArticle(by idArticle: String) -> AnyPublisher<ArticleModel, Error>
}
