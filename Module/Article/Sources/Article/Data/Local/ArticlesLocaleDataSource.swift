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
//  func add(entities: [Response]) -> AnyPublisher<Bool, Error>
//  func add(entity: Response) -> AnyPublisher<Bool, Error>
//  func get(itemId: String) -> AnyPublisher<Response, Error>
//  func update(itemId: Int, entity: Response) -> AnyPublisher<Bool, Error>
//  func delete(entity: Response) -> AnyPublisher<Bool, Error>
}


public struct ArticlesLocaleDataSourceImpl: ArticlesLocaleDataSource {
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
}
