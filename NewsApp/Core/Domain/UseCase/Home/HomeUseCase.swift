//
//  HomeUseCase.swift
//  NewsApp
//
//  Created by Wanhar on 16/02/21.
//

import Foundation
import Combine

protocol HomeUseCase {
  
  func getArticles() -> AnyPublisher<[ArticleModelOld], Error>
  
}
