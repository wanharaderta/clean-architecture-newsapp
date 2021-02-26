////
////  File.swift
////  
////
////  Created by Wanhar on 25/02/21.
////
//
//import Foundation
//import Combine
//import Core
//
//public struct Interactor<Request, Response, R: Repository>: UseCase
//where R.Request == Request, R.Response == Response {
//  
//  private let _repository: R
//  private let _item: P
//  
//  public init(repository: R, item: P) {
//    self._repository = repository
//    self._item = item
//  }
//  
//  public func execute(request: Request?) -> AnyPublisher<Response, Error> {
//    //repository as! AnyPublisher<DetailInteractor<ArticlesRepository>.Response, Error>
//  }
//  
//  public func getArticle() -> ArticleModel {
//    
//  }
//  
//  public func addFavoriteArticle() -> AnyPublisher<Bool, Error> {
//    
//  }
//  
//  public func removeFavoriteArticle() -> AnyPublisher<Bool, Error> {
//    <#code#>
//  }
//}
////Interactor<String, [ArticleModel], ArticlesRepository <
////                                ArticlesLocaleDataSource,
////                                ArticlesRemoteDataSource,
////                                ArticlesTransformer>
////
////public struct Interactor<Request, Response, R: Repository>: UseCase
////where R.Request == Request, R.Response == Response {
////
//  private let _repository: R
//
//  public init(repository: R) {
//    _repository = repository
//  }
//
//  public func execute(request: Request?) -> AnyPublisher<Response, Error> {
//    _repository.execute(request: request)
//  }
//}
