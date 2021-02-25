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
  
  func getFavoriteArticles() -> AnyPublisher<[ArticleEntityOld], Error>
  func getArticle(by title: String) -> AnyPublisher<ArticleEntityOld, Error>
  func addFavoriteArticle(from  article: ArticleEntityOld) -> AnyPublisher<Bool, Error>
  func removeFavoriteArticle(from  article: ArticleEntityOld) -> AnyPublisher<Bool, Error>
}

final class LocaleDataSourceOld: NSObject {
  
  private let realm: Realm?
  
  private init(realm: Realm?) {
    self.realm = realm
  }
  
  static let instance: (Realm?) -> LocaleDataSourceOld = { realmDB in
    return LocaleDataSourceOld(realm: realmDB)
  }
}

extension LocaleDataSourceOld: LocaleDataSourceProtocol {
  
  func getArticle(
    by title: String
  ) -> AnyPublisher<ArticleEntityOld, Error> {
    return Future<ArticleEntityOld, Error> { completion in
      if let realm = self.realm {
        let articles: Results<ArticleEntityOld> = {
          realm.objects(ArticleEntityOld.self)
            .filter("title = '\(title)'")
        }()
        
        guard let article = articles.first else {
          //completion(.failure(DatabaseError.requestFailed))
          return
        }
        completion(.success(article))
      } else {
        //completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func getFavoriteArticles() -> AnyPublisher<[ArticleEntityOld], Error> {
    return Future<[ArticleEntityOld], Error> { completion in
      if let realm = self.realm {
        let articleEntities = {
          realm.objects(ArticleEntityOld.self)
            .filter("favorite = \(true)")
        }()
        completion(.success(articleEntities.toArray(ofType: ArticleEntityOld.self)))
      } else {
       // completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func removeFavoriteArticle(
    from article: ArticleEntityOld
  ) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        do {
          try realm.write {
            let objectsToDelete = realm.objects(ArticleEntityOld.self)
              .filter("idArticle = '\(article.idArticle)'")
            
            realm.delete(objectsToDelete)
            completion(.success(false))
          }
        } catch {
          //completion(.failure(DatabaseError.requestFailed))
        }
      } else {
       // completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func addFavoriteArticle(
    from article: ArticleEntityOld
  ) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        do {
          try realm.write {
            if realm.isInWriteTransaction {
              if realm.object(ofType: ArticleEntityOld.self, forPrimaryKey: article.idArticle) != nil {
           //     completion(.failure(DatabaseError.requestFailed))
              } else {
                article.favorite = true
                realm.add(article, update: .all)
                completion(.success(true))
              }
            } else {
             // completion(.failure(DatabaseError.requestFailed))
            }
          }
        } catch {
          //completion(.failure(DatabaseError.requestFailed))
        }
      } else {
       // completion(.failure(DatabaseError.invalidInstance))//
      }
    }.eraseToAnyPublisher()
  }
}
