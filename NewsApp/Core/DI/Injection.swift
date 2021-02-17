//
//  Injection.swift
//  NewsApp
//
//  Created by Wanhar on 17/02/21.
//

import Foundation
import RealmSwift

final class Injection: NSObject {
  
  private func provideRepository() -> ArticlesRepository {
    let ream = try? Realm()
    
    let remote: RemoteDataSource = RemoteDataSource.instance
    
    return ArticlesRepositoryImpl.instance(remote)
  }
  
  func provideHome() -> HomeUseCase {
    let repository = provideRepository()
    return HomeInteractor(repository: repository)
  }
  
  func provideDetail(article: ArticleModel) -> DetailUseCase {
    let repository = provideRepository()
    return DetailInteractor(repository: repository,article: article)
  }
  
  func provideFavorite(article: ArticleModel) -> DetailUseCase {
    let repository = provideRepository()
    return DetailInteractor(repository: repository,article: article)
  }
  
}
