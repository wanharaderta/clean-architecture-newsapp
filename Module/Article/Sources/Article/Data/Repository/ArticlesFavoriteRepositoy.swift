//
//  File.swift
//  
//
//  Created by Wanhar on 25/02/21.
//

import Foundation
import Core
import Combine

public struct ArticleFavoriteRepository<
  ArticlesLocaleDataSourceImpl: ArticlesLocaleDataSource,
  Transformer: ArticlesMapper> : Repository
where
  ArticlesLocaleDataSourceImpl.Request == String,
  ArticlesLocaleDataSourceImpl.Response == ArticleEntity,
  Transformer.Response == [ArticleResponse],
  Transformer.Entity == [ArticleEntity],
  Transformer.Domain == [ArticleModel] {

  public typealias Request = String
  public typealias Response = [ArticleModel]
  
  private let _locale: ArticlesLocaleDataSourceImpl
  private let _mapper: Transformer
  
  public init(
    locale: ArticlesLocaleDataSourceImpl,
    mapper: Transformer
  ) {
    _locale = locale
    _mapper = mapper
  }
  
  public func execute(request: String?) -> AnyPublisher<[ArticleModel], Error> {
    guard let request = request else { fatalError("Request cannot be empty") }
    return self._locale.list(request: request)
      .map { _mapper.transformEntitiesToDomain(entities: $0) }
      .eraseToAnyPublisher()
  }
}
