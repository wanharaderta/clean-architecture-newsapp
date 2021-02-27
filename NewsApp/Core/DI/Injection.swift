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

final class Injection: NSObject {
  func provideArticles<U: UseCase>() -> U where U.Request == String, U.Response == [ArticleModel] {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
         fatalError(errorMessageDelegate)
    }
    let locale = ArticlesLocaleDataSourceImpl(realm: appDelegate.realm)
    let remote = ArticlesRemoteDataSource(endpoint: Endpoints.Gets.news.url)
    let mapper = ArticlesTransformer()
    let repository = ArticlesRepository(
      localeDataSource: locale,
      remoteDataSource: remote,
      mapper: mapper)
    guard let interactor = Interactor(repository: repository) as? U else {
      fatalError(errorMessageInteractor)
    }
    return interactor
  }
  
  func provideFavorites<U: UseCase>() -> U where U.Request == String, U.Response == [ArticleModel] {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
         fatalError(errorMessageDelegate)
    }
    let locale = ArticlesLocaleDataSourceImpl(realm: appDelegate.realm)
    let mapper = ArticlesTransformer()
    let repository = ArticleFavoriteRepository(
      locale: locale,
      mapper: mapper)
    guard let interactor = Interactor(repository: repository) as? U else {
      fatalError(errorMessageInteractor)
    }
    return interactor
  }
  
  func provideDetail<U: UseCase>() -> U where U.Request == ArticleModel, U.Response == Bool {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
         fatalError(errorMessageDelegate)
    }
    let locale = ArticleDetailLocaleDataSourceImpl(realm: appDelegate.realm)
    let mapper = DetailTransformer()
    let repository = DetailRepository(
      locale: locale,
      mapper: mapper)
    guard let interactor = Interactor(repository: repository) as? U else {
      fatalError(errorMessageInteractor)
    }
    return interactor
  }
  
  func provideArticle<U: UseCase>() -> U where U.Request == String, U.Response == ArticleModel {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
         fatalError(errorMessageDelegate)
    }
    let locale = ArticleLocaleDataSourceImpl(realm: appDelegate.realm)
    let mapper = ArticleTransformer()
    let repository = ArticleRepository(
      locale: locale,
      mapper: mapper)
    guard let interactor = Interactor(repository: repository) as? U else {
      fatalError(errorMessageInteractor)
    }
    return interactor
  }
}

