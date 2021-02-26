//
//  NewsRepositoryImpl.swift
//  NewsApp
//
//  Created by Wanhar on 16/02/21.
//

import Foundation
import Combine

final class ArticlesRepositoryImpl: NSObject {
  
  typealias ArticlesInstance = (RemoteDataSource, LocaleDataSourceOld) -> ArticlesRepositoryImpl
  
  fileprivate let remote: RemoteDataSource
  fileprivate let locale: LocaleDataSourceOld
  
  private init(remote: RemoteDataSource, locale: LocaleDataSourceOld) {
    self.remote = remote
    self.locale = locale
  }
  static let instance: ArticlesInstance = { remoteRepositoy, localeRepository in
    return ArticlesRepositoryImpl(remote: remoteRepositoy, locale: localeRepository)
  }
}

extension ArticlesRepositoryImpl: ArticlesRepositoryOld {

  func getArticles() -> AnyPublisher<[ArticleModelOld], Error> {
    return self.remote.getArticles()
      .map { ArticleMapperOld.mapArticleResponseToDomain(input: $0) }
      .eraseToAnyPublisher()
  }
  
  func getFavoriteArticles() -> AnyPublisher<[ArticleModelOld], Error> {
    return self.locale.getFavoriteArticles()
      .map { ArticleMapperOld.mapArticleEntitiesToDomain(input: $0) }
      .eraseToAnyPublisher()
  }
  
  func getArticle(by title: String) -> AnyPublisher<ArticleModelOld, Error> {
    return self.locale.getArticle(by: title)
      .map { ArticleMapperOld.mapArticleEntityToDomain(input: $0) }
      .eraseToAnyPublisher()
  }
  
  func addFavoriteArticle(from article: ArticleModelOld) -> AnyPublisher<Bool, Error> {
    let artc  = ArticleMapperOld.mapArticleDomainToEntity(input: article)
    return self.locale.addFavoriteArticle(from: artc)
      .eraseToAnyPublisher()
  }
  
  func removeFavoriteArticle(from article: ArticleModelOld) -> AnyPublisher<Bool, Error> {
    let artc  = ArticleMapperOld.mapArticleDomainToEntity(input: article)
    return self.locale.removeFavoriteArticle(from: artc)
      .eraseToAnyPublisher()
  }

}
