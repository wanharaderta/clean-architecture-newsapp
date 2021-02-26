//
//  File.swift
//  
//
//  Created by Wanhar on 26/02/21.
//
import Foundation
import Core
import RealmSwift
import Combine

public protocol ArticleLocaleDataSource: LocaleDataSource {
//  func add(entities: [Response]) -> AnyPublisher<Bool, Error>
//  func add(entity: Response) -> AnyPublisher<Bool, Error>
  func get(itemId: String) -> AnyPublisher<Response, Error>
//  func update(itemId: Int, entity: Response) -> AnyPublisher<Bool, Error>
//  func delete(entity: Response) -> AnyPublisher<Bool, Error>
}


public struct ArticleLocaleDataSourceImpl: ArticleLocaleDataSource {
  public typealias Request = String
  public typealias Response = ArticleEntity
  
  private let _realm: Realm
  
  public init(realm: Realm) {
    _realm = realm
  }

  public func get(itemId: String) -> AnyPublisher<ArticleEntity, Error> {
    return Future<ArticleEntity, Error> { completion in
        let items: Results<ArticleEntity> = {
          _realm.objects(ArticleEntity.self)
            .filter("title = '\(itemId)'")
        }()
        
        guard let item = items.first else {
          completion(.failure(DatabaseError.requestFailed))
          return
        }
        completion(.success(item))
    }.eraseToAnyPublisher()
  }
}
