//
//  NewsRepositoryImpl.swift
//  NewsApp
//
//  Created by Wanhar on 16/02/21.
//

import Foundation
import Combine

final class ArticlesRepositoryImpl: NSObject {
  
  typealias ArticlesInstance = (RemoteDataSource, LocaleDataSource) -> ArticlesRepositoryImpl
  
  fileprivate let remote: RemoteDataSource
  fileprivate let locale: LocaleDataSource
  
  private init(remote: RemoteDataSource, locale: LocaleDataSource) {
    self.remote = remote
    self.locale = locale
  }
  static let instance: ArticlesInstance = { remoteRepositoy, localeRepository in
    return ArticlesRepositoryImpl(remote: remoteRepositoy, locale: localeRepository)
  }
}

extension ArticlesRepositoryImpl: ArticlesRepository {

  func getArticles() -> AnyPublisher<[ArticleModel], Error> {
    return self.remote.getArticles()
      .map { ArticleMapper.mapArticleResponseToDomain(input: $0) }
      .eraseToAnyPublisher()
  }
  
  func getFavoriteArticles() -> AnyPublisher<[ArticleModel], Error> {
    return self.locale.getFavoriteArticles()
      .map { ArticleMapper.mapArticleEntitiesToDomain(input: $0) }
      .eraseToAnyPublisher()
  }
  
  func getArticle(by title: String) -> AnyPublisher<ArticleModel, Error> {
    return self.locale.getArticle(by: title)
      .map { ArticleMapper.mapArticleEntityToDomain(input: $0) }
      .eraseToAnyPublisher()
  }
  
  func addFavoriteArticle(from article: ArticleModel) -> AnyPublisher<Bool, Error> {
    let artc  = ArticleMapper.mapArticleDomainToEntity(input: article)
    return self.locale.addFavoriteArticle(from: artc)
      .eraseToAnyPublisher()
  }
  
  func removeFavoriteArticle(from article: ArticleModel) -> AnyPublisher<Bool, Error> {
    let artc  = ArticleMapper.mapArticleDomainToEntity(input: article)
    return self.locale.removeFavoriteArticle(from: artc)
      .eraseToAnyPublisher()
  }

}
