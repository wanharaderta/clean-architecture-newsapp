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
  public typealias Response = CategoryModuleEntity
  
  private let _realm: Realm
  
  public init(realm: Realm) {
    _realm = realm
  }
  
  public func list(request: Any?) -> AnyPublisher<[ArticleEntity], Error> {
    return Future<[ArticleEntity], Error> { completion in
      if let realm = self.realm {
        let articleEntities = {
          realm.objects(ArticleEntityOld.self)
            .filter("favorite = \(true)")
        }()
        completion(.success(articleEntities.toArray(ofType: ArticleEntity.self)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
}
