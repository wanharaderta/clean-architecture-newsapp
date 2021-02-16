//
//  ArticleMapper.swift
//  NewsApp
//
//  Created by Wanhar on 16/02/21.
//

import Foundation

final class ArticleMapper {
  
  static func mapArticleResponseToDomain(
    input articleResponse: [ArticleResponse]
  ) -> [ArticleModel] {
    
    return articleResponse.map { result in
      return ArticleModel(
        id: UUID(),
        author: result.author ?? "",
        sourceName: result.source?.name ?? "",
        title: result.title ?? "",
        urlToImage: result.urlToImage ?? "",
        content: result.content ?? "",
        description:result.description ?? "")
    }
  }
}
