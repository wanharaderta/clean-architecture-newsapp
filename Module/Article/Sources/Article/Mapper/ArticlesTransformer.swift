//
//  File.swift
//  
//
//  Created by Wanhar on 24/02/21.
//

import Foundation
import Core

public struct ArticlesTransformer: Mapper {
  public typealias Response = [ArticleResponse]
  public typealias Entity = [ArticleEntity]
  public typealias Domain = [ArticleModel]
  
  public init() {}
  
  public func transformResponseToDomain(
    response: [ArticleResponse]
  ) -> [ArticleModel] {
    return response.map { result in
      return ArticleModel(
        id: result.id,
        author: result.author ?? "",
        sourceName: result.source?.name ?? "",
        title: result.title ?? "",
        urlToImage: result.urlToImage ?? "",
        content: result.content ?? "",
        description:result.description ?? "")
    }
  }
}
