//
//  RemoteDataSource.swift
//  NewsApp
//
//  Created by Wanhar on 16/02/21.
//

import Foundation
import Alamofire
import Combine

protocol RemoteDataSourceProtocol: class {
  
  func getArticles() -> AnyPublisher<[ArticleResponse], Error>
  
}

final class RemoteDataSource: NSObject {

  private override init() { }

  static let instance: RemoteDataSource =  RemoteDataSource()

}

extension RemoteDataSource: RemoteDataSourceProtocol {

  func getArticles() -> AnyPublisher<[ArticleResponse], Error> {
    return Future<[ArticleResponse], Error> { completion in
      if let url = URL(string: Endpoints.Gets.news.url) {
        AF.request(url)
          .validate()
          .responseDecodable(of: ArticlesResponse.self) { response in
            switch response.result {
            case .success(let value):
              completion(.success(value.articles))
            case .failure:
              completion(.failure(URLError.invalidResponse))
            }
          }
      }
    }.eraseToAnyPublisher()
  }

}
