//
//  ArticleMapper.swift
//  NewsApp
//
//  Created by Wanhar on 16/02/21.
//

import Foundation

final class ArticleMapperOld {
  
  static func mapArticleResponseToDomain(
    input articleResponse: [ArticleResponse]
  ) -> [ArticleModelOld] {
    
    return articleResponse.map { result in
      return ArticleModelOld(
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
    input articleEntities: [ArticleEntityOld]
  ) -> [ArticleModelOld] {
    return articleEntities.map { result in
      return ArticleModelOld(
        id: result.idArticle,
        author: result.author,
        sourceName: result.sourceName,
        title: result.title,
        urlToImage: result.urlToImage,
        content: result.content,
        description: result.desc)
    }
  }
  
  static func mapArticleEntityToDomain(
    input articleEntity: ArticleEntityOld
  ) -> ArticleModelOld {
    return ArticleModelOld(
      id: articleEntity.idArticle,
      author: articleEntity.author,
      sourceName: articleEntity.sourceName,
      title: articleEntity.title,
      urlToImage: articleEntity.urlToImage,
      content: articleEntity.content,
      description: articleEntity.desc,
      favorite: articleEntity.favorite
    )
  }
  
  static func mapArticleDomainToEntity(
    input article: ArticleModelOld
  ) -> ArticleEntityOld {
    let articleEntity = ArticleEntityOld()
    articleEntity.idArticle = article.id
    articleEntity.author = article.author
    articleEntity.sourceName = article.sourceName
    articleEntity.title = article.title
    articleEntity.urlToImage = article.urlToImage
    articleEntity.content = article.content
    articleEntity.desc = article.description
    return articleEntity
  }
}
