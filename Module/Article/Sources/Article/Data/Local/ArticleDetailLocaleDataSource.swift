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

public protocol ArticleDetailLocaleDataSource: LocaleDataSource {
  //func list(request: Request?) -> AnyPublisher<[Response], Error>
//  func add(entities: [Response]) -> AnyPublisher<Bool, Error>
  func add(entity: Request) -> AnyPublisher<Bool, Error>
 // func get(itemId: String) -> AnyPublisher<Response, Error>
//  func update(itemId: Int, entity: Response) -> AnyPublisher<Bool, Error>
  func delete(entity: Request) -> AnyPublisher<Bool, Error>
}

public struct ArticleDetailLocaleDataSourceImpl: ArticleDetailLocaleDataSource {

  public typealias Request = ArticleEntity
  public typealias Response = Bool
  
  private let _realm: Realm
  
  public init(realm: Realm) {
    _realm = realm
  }
  
  public func add(entity: ArticleEntity) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
        do {
          try _realm.write {
            if _realm.isInWriteTransaction {
              if _realm.object(ofType: ArticleEntity.self, forPrimaryKey: entity.itemId) != nil {
                completion(.failure(DatabaseError.requestFailed))
              } else {
                entity.favorite = true
                _realm.add(entity, update: .all)
                completion(.success(true))
              }
            } else {
              completion(.failure(DatabaseError.requestFailed))
            }
          }
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
    }.eraseToAnyPublisher()
  }

  public func delete(entity: ArticleEntity) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
        do {
          try _realm.write {
            let objectsToDelete = _realm.objects(ArticleEntity.self)
              .filter("itemId = '\(entity.itemId)'")
            _realm.delete(objectsToDelete)
            completion(.success(false))
          }
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
    }.eraseToAnyPublisher()
  }
}


