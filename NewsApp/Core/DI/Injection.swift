//
//  Injection.swift
//  NewsApp
//
//  Created by Wanhar on 17/02/21.
//

import Foundation
import UIKit
import RealmSwift
import Article
import Core

//final class Injection: NSObject {
//
//  func provideArticle<U: UseCase>() -> U where U.Request == Any, U.Response == [ArticleModel] {
//    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//         fatalError("no Application Delegate found")
//    }
//    //let appDelegate = UIApplication.shared.delegate as? AppDelegate
//    let locale = ArticlesLocaleDataSource(realm: appDelegate.realm)
//    let remote = ArticlesRemoteDataSource(endpoint: Endpoints.Gets.news.url)
//    let mapper = ArticlesTransformer()
//    let repository = ArticlesRepository(
//      localeDataSource: locale,
//      remoteDataSource: remote,
//      mapper: mapper)
////    guard let interactor = Interactor(repository: repository) as? U else {
////      fatalError("Interactor no found")
////    }
//    fatalError("repo \(repository)")
//
//    return (Interactor(repository: repository) as? U)!
//  }
//
//  private func provideRepository() -> ArticlesRepositoryOld {
//    let ream = try? Realm()
//    let remote: RemoteDataSource = RemoteDataSource.instance
//    let locale: LocaleDataSourceOld = LocaleDataSourceOld.instance(ream)
//    return ArticlesRepositoryImpl.instance(remote, locale)
//  }
//  func provideHome() -> HomeUseCase {
//    let repository = provideRepository()
//    return HomeInteractor(repository: repository)
//  }
//  func provideDetail(article: ArticleModelOld) -> DetailUseCase {
//    let repository = provideRepository()
//    return DetailInteractor(repository: repository, article: article)
//  }
//  func provideFavorite() -> FavoriteUseCase {
//    let repository = provideRepository()
//    return FavoriteInteractor(repository: repository)
//  }
//}

final class Injection: NSObject {
  
  func provideArticle<U: UseCase>() -> U where U.Request == String, U.Response == [ArticleModel] {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
         fatalError("no Application Delegate found")
    }
    let locale = ArticlesLocaleDataSource(realm: appDelegate.realm)
    let remote = ArticlesRemoteDataSource(endpoint: Endpoints.Gets.news.url)
    let mapper = ArticlesTransformer()
    let repository = ArticlesRepository(
      localeDataSource: locale,
      remoteDataSource: remote,
      mapper: mapper)
    guard let interactor = Interactor(repository: repository) as? U else {
      fatalError("Duh....")
    }
    return interactor
  }
  
  private func provideRepository() -> ArticlesRepositoryOld {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
         fatalError("no Application Delegate found")
    }
    let remote: RemoteDataSource = RemoteDataSource.instance
    let locale: LocaleDataSourceOld = LocaleDataSourceOld.instance(appDelegate.realm)
    return ArticlesRepositoryImpl.instance(remote, locale)
  }
  func provideHome() -> HomeUseCase {
    let repository = provideRepository()
    return HomeInteractor(repository: repository)
  }
  func provideDetail(article: ArticleModelOld) -> DetailUseCase {
    let repository = provideRepository()
    return DetailInteractor(repository: repository, article: article)
  }
  func provideFavorite() -> FavoriteUseCase {
    let repository = provideRepository()
    return FavoriteInteractor(repository: repository)
  }
}

