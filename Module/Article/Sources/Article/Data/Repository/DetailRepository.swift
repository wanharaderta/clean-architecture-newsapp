//
//  File.swift
//  
//
//  Created by Wanhar on 25/02/21.
//

import Foundation
import Core
import Combine

public struct DetailRepository<
  ArticleDetailLocaleDataSourceImpl: ArticleDetailLocaleDataSource,
  Transformer: DetailMapper> : Repository
where
  ArticleDetailLocaleDataSourceImpl.Request == ArticleEntity,
  ArticleDetailLocaleDataSourceImpl.Response == Bool,
  Transformer.Response == ArticleResponse,
  Transformer.Entity == ArticleEntity,
  Transformer.Domain == ArticleModel {
  
  public typealias Request = ArticleModel
  public typealias Response = Bool
  
  private let _locale: ArticleDetailLocaleDataSourceImpl
  private let _mapper: Transformer
  
  public init(
    locale: ArticleDetailLocaleDataSourceImpl,
    mapper: Transformer
  ) {
    _locale = locale
    _mapper = mapper
  }
  
  public func execute(request: ArticleModel?) -> AnyPublisher<Bool, Error> {
    guard let request = request else {
      fatalError("Request cannot be empty")
    }
    let item  = _mapper.transformDomainToEntity(domain: request)
    if request.favorite {
      return self._locale.delete(entity: item)
        .eraseToAnyPublisher()
    } else {
      return self._locale.add(entity: item)
        .eraseToAnyPublisher()
    }
   
  }
}
