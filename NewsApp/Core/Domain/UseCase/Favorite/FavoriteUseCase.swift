//
//  FavoriteUseCase.swift
//  NewsApp
//
//  Created by Wanhar on 18/02/21.
//

import Combine

protocol FavoriteUseCase {
  
  func getArticles() -> AnyPublisher<[ArticleModel], Error>
  
}
