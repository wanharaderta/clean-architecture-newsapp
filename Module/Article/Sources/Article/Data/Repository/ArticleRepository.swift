//
//  File.swift
//  
//
//  Created by Wanhar on 26/02/21.
//

import Foundation
import Core
import Combine

public struct ArticleRepository<
  ArticleLocaleDataSourceImpl: ArticleLocaleDataSource,
  Transformer: ArticleMapper> : Repository
where
  ArticleLocaleDataSourceImpl.Request == String,
  ArticleLocaleDataSourceImpl.Response == ArticleEntity,
  Transformer.Response == ArticleResponse,
  Transformer.Entity == ArticleEntity,
  Transformer.Domain == ArticleModel {

  public typealias Request = String
  public typealias Response = ArticleModel
  
  private let _locale: ArticleLocaleDataSourceImpl
  private let _mapper: Transformer
  
  public init(
    locale: ArticleLocaleDataSourceImpl,
    mapper: Transformer
  ) {
    _locale = locale
    _mapper = mapper
  }
  
  public func execute(request: String?) -> AnyPublisher<ArticleModel, Error> {
    guard let request = request else { fatalError("Request cannot be empty") }
    return self._locale.get(itemId: request)
      .map { _mapper.transformEntityToDomain(entity: $0)}
      .eraseToAnyPublisher()
  }
  

}
