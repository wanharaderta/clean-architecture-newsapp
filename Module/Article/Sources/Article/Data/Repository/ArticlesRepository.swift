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
  ArticleLocaleDataSource: LocalDataSource,
  ArticleRemoteDataSource: DataSource,
  Transformer: Mapper> : Repository
where
  ArticleLocaleDataSource.Response == ArticleEntity,
  ArticleRemoteDataSource.Response == [ArticleResponse],
  Transformer.Response == [ArticleResponse],
  Transformer.Entity == [ArticleEntity],
  Transformer.Domain == [ArticleModel]{
  
  public typealias Request = Any
  public typealias Response = [ArticleModel]
  
  private let _locale: ArticleLocaleDataSource
  private let _remote: ArticleRemoteDataSource
  private let _mapper: Transformer
  
  public init(
    localeDataSource: ArticleLocaleDataSource,
    remoteDataSource: ArticleRemoteDataSource,
    mapper: Transformer
  ) {
    _locale = localeDataSource
    _remote = remoteDataSource
    _mapper = mapper
  }
  
  public func getList(request: Any?) -> AnyPublisher<[ArticleModel], Error> {
    return self._remote.getList(request: nil)
      .map { ArticleMapper.mapArticleResponseToDomain(input: $0) }
      .eraseToAnyPublisher()
  }
  
}
