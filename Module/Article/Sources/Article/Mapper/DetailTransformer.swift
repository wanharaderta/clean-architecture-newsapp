//
//  File.swift
//  
//
//  Created by Wanhar on 25/02/21.
//

import Foundation
import Core

public protocol DetailMapper: Mapper {
  func transformDomainToEntity(domain: Domain) -> Entity
}

public struct DetailTransformer: DetailMapper {
  public typealias Response = ArticleResponse
  public typealias Entity = ArticleEntity
  public typealias Domain = ArticleModel
  
  public init() {}
  
  public func transformDomainToEntity(domain: ArticleModel) -> ArticleEntity {
    let articleEntity = ArticleEntity()
    articleEntity.itemId = domain.id
    articleEntity.author = domain.author
    articleEntity.sourceName = domain.sourceName
    articleEntity.title = domain.title
    articleEntity.urlToImage = domain.urlToImage
    articleEntity.content = domain.content
    articleEntity.desc = domain.description
    return articleEntity
  }

}
