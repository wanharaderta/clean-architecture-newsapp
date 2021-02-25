//
//  File.swift
//  
//
//  Created by Wanhar on 24/02/21.
//

import Foundation
import Combine
import Core

public struct ArticlesRepository<
  ArticlesLocaleDataSource: LocaleDataSource,
  ArticlesRemoteDataSource: DataSource,
  Transformer: Mapper> : Repository
where
  ArticlesLocaleDataSource.Response == ArticleEntity,
  ArticlesRemoteDataSource.Response == [ArticleResponse],
  Transformer.Response == [ArticleResponse],
  Transformer.Entity == [ArticleEntity],
  Transformer.Domain == [ArticleModel]{

  public typealias Request = String
  public typealias Response = [ArticleModel]
  
  private let _locale: ArticlesLocaleDataSource
  private let _remote: ArticlesRemoteDataSource
  private let _mapper: Transformer
  
  public init(
    localeDataSource: ArticlesLocaleDataSource,
    remoteDataSource: ArticlesRemoteDataSource,
    mapper: Transformer
  ) {
    _locale = localeDataSource
    _remote = remoteDataSource
    _mapper = mapper
  }
  
  public func execute(request: String?) -> AnyPublisher<[ArticleModel], Error> {
    return self._remote.execute(request: nil)
      .map {  _mapper.transformResponseToDomain(response: $0) }
      .eraseToAnyPublisher()
  }
}
