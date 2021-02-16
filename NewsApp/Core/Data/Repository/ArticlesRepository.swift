//
//  NewsRepository.swift
//  NewsApp
//
//  Created by Wanhar on 16/02/21.
//

import Foundation
import Combine

protocol ArticlesRepository: class {
  
  func getArticles() -> AnyPublisher<[ArticleResponse], Error>
  
}
