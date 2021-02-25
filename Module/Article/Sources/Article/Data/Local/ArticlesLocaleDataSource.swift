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

public struct ArticlesLocaleDataSource: LocaleDataSource {
  
  public typealias Request = Any
  public typealias Response = ArticleEntity
  
  private let _realm: Realm
  
  public init(realm: Realm) {
    _realm = realm
  }
  
  public func list(request: Any?) -> AnyPublisher<[ArticleEntity], Error> {
    return Future<[ArticleEntity], Error> { completion in
      let articleEntities = {
        _realm.objects(ArticleEntity.self)
          .filter("favorite = \(true)")
      }()
      completion(.success(articleEntities.toArray(ofType: ArticleEntity.self)))
    }.eraseToAnyPublisher()
  }
  
  public func add(entities: [ArticleEntity]) -> AnyPublisher<Bool, Error> {
    fatalError()
  }
  
  public func get(itemId: String) -> AnyPublisher<ArticleEntity, Error> {
    fatalError()
  }
  
  public func update(itemId: Int, entity: ArticleEntity) -> AnyPublisher<Bool, Error> {
    fatalError()
  }
  
}
