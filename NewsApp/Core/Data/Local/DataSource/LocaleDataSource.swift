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
  func updateFavoriteArticle(by title: String) -> AnyPublisher<ArticleEntity, Error>
  func getArticle(by title: String) -> AnyPublisher<ArticleEntity, Error>
  func addFavoriteArticle(from  article: ArticleEntity) -> AnyPublisher<Bool, Error>
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
  
  func getArticle(
    by title: String
  ) -> AnyPublisher<ArticleEntity, Error> {
    return Future<ArticleEntity, Error> { completion in
      if let realm = self.realm {
        let articles: Results<ArticleEntity> = {
          realm.objects(ArticleEntity.self)
            .filter("title = '\(title)'")
        }()
        
        guard let article = articles.first else {
          completion(.failure(DatabaseError.requestFailed))
          return
        }
        completion(.success(article))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func getFavoriteArticles() -> AnyPublisher<[ArticleEntity], Error> {
    return Future<[ArticleEntity], Error> { completion in
      if let realm = self.realm {
        let articleEntities = {
          realm.objects(ArticleEntity.self)
            .filter("favorite = \(true)")
        }()
        completion(.success(articleEntities.toArray(ofType: ArticleEntity.self)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func updateFavoriteArticle(by idArticle: String) -> AnyPublisher<ArticleEntity, Error> {
    return Future<ArticleEntity, Error> { completion in
      if let realm = self.realm, let articleEntity = {
        realm.objects(ArticleEntity.self).filter("idArticle = '\(idArticle)'")
      }().first {
        do {
          try realm.write {
            articleEntity.setValue(!articleEntity.favorite, forKey: "favorite")
          }
          completion(.success(articleEntity))
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func addFavoriteArticle(
    from article: ArticleEntity
  ) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        do {
          try realm.write {
            article.favorite = true
            realm.add(article)
            completion(.success(true))
          }
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
}
