//
//  File.swift
//  
//
//  Created by Wanhar on 26/02/21.
//

import Foundation
import Core

public protocol ArticleMapper: Mapper {
  func transformEntityToDomain(entity: Entity) -> Domain
}

public struct ArticleTransformer: ArticleMapper {
  public typealias Response = ArticleResponse
  public typealias Entity = ArticleEntity
  public typealias Domain = ArticleModel
  
  public init() {}

  public func transformEntityToDomain(entity: ArticleEntity) -> ArticleModel {
    return ArticleModel(
      id: entity.itemId,
      author: entity.author,
      sourceName: entity.sourceName,
      title: entity.title,
      urlToImage: entity.urlToImage,
      content: entity.content,
      description: entity.desc,
      favorite: entity.favorite
    )
  }
}
