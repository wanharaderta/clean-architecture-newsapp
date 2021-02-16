//
//  NewsRepositoryImpl.swift
//  NewsApp
//
//  Created by Wanhar on 16/02/21.
//

import Foundation
import Combine


final class ArticlesRepositoryImpl: NSObject {
  
  typealias ArticlesInstance = (RemoteDataSource) -> ArticlesRepositoryImpl
  
  fileprivate let remote: RemoteDataSource
  
  private init(remote: RemoteDataSource){
    self.remote = remote
  }
  
  static let instance: ArticlesInstance = { remoteRepositoy in
    return ArticlesRepositoryImpl(remote: remoteRepositoy)
  }
  
}

extension ArticlesRepositoryImpl: ArticlesRepository {
  
  func getArticles() -> AnyPublisher<[ArticleModel], Error> {
    return self.remote.getArticles()
      .map { ArticleMapper.mapArticleResponseToDomain(input: $0) }
      .eraseToAnyPublisher()
  }
  
}
