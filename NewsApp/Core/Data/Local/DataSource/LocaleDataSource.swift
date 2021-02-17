//
//  LocaleDataSource.swift
//  NewsApp
//
//  Created by Wanhar on 18/02/21.
//
import Foundation
import Combine
import RealmSwift


protocol LocaleDataSourceProtocol {
  
  func getFavoriteArticles() -> AnyPublisher<[ArticleEntity], Error>
}

final class LocaleDataSource: NSObject {
  
  private let realm: Realm?

  private init(realm: Realm?) {
    self.realm = realm
  }

  static let instance: (Realm?) -> LocaleDataSource = { realmDB in
    return LocaleDataSource(realm: realmDB)
  }
}

extension LocaleDataSource: LocaleDataSourceProtocol {
  
  func getFavoriteArticles() -> AnyPublisher<[ArticleEntity], Error> {
    
  }
}
