//
//  File.swift
//  
//
//  Created by Wanhar on 24/02/21.
//

import Foundation
import Core
import RealmSwift
import Combine

public protocol ArticlesLocaleDataSource: LocaleDataSource {
  func list(request: Request?) -> AnyPublisher<[Response], Error>
}


public struct ArticlesLocaleDataSourceImpl: ArticlesLocaleDataSource {
  
  public typealias Request = String
  public typealias Response = ArticleEntity
  
  private let _realm: Realm
  
  public init(realm: Realm) {
    _realm = realm
  }
  
  public func list(request: String?) -> AnyPublisher<[ArticleEntity], Error> {
    return Future<[ArticleEntity], Error> { completion in
      let articleEntities = {
        _realm.objects(ArticleEntity.self)
          .filter("favorite = \(true)")
      }()
      completion(.success(articleEntities.toArray(ofType: ArticleEntity.self)))
    }.eraseToAnyPublisher()
  }

}
