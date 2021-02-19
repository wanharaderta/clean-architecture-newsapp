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
    let locale: LocaleDataSource = LocaleDataSource.instance(ream)
    return ArticlesRepositoryImpl.instance(remote,locale)
  }
  
  func provideHome() -> HomeUseCase {
    let repository = provideRepository()
    return HomeInteractor(repository: repository)
  }
  
  func provideDetail(article: ArticleModel) -> DetailUseCase {
    let repository = provideRepository()
    return DetailInteractor(repository: repository,article: article)
  }
  
  func provideFavorite() -> FavoriteUseCase {
    let repository = provideRepository()
    return FavoriteInteractor(repository: repository)
  }
  
}
