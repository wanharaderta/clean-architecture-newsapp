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
        id: result.id,
        author: result.author ?? "",
        sourceName: result.source?.name ?? "",
        title: result.title ?? "",
        urlToImage: result.urlToImage ?? "",
        content: result.content ?? "",
        description:result.description ?? "")
    }
  }
  
  static func mapArticleEntitiesToDomain(
    input articleEntities: [ArticleEntity]
  ) -> [ArticleModel] {
    return articleEntities.map { result in
      return ArticleModel(
        id: result.id,
        author: result.author,
        sourceName: result.sourceName,
        title: result.title,
        urlToImage: result.urlToImage,
        content: result.content,
        description: result.desc)
    }
  }
  
  static func mapArticleEntityToDomain(
    input articleEntity: ArticleEntity
  ) -> ArticleModel {
    return ArticleModel(
      id: articleEntity.id,
      author: articleEntity.author,
      sourceName: articleEntity.sourceName,
      title: articleEntity.title,
      urlToImage: articleEntity.urlToImage,
      content: articleEntity.content,
      description: articleEntity.desc
    )
  }
  
}
