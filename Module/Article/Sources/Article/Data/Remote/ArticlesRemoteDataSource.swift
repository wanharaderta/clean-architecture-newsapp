//
//  File.swift
//  
//
//  Created by Wanhar on 24/02/21.
//

import Foundation
import Combine
import Core
import Alamofire

public struct ArticlesRemoteDataSource: DataSource {
  public typealias Request = Any
  public typealias Response = [ArticlesResponse]
  
  private let _endpoint: String
  
  public init(endpoint: String) {
    _endpoint = endpoint
  }
  
  public func getList(request: Any?) -> AnyPublisher<[ArticlesResponse], Error> {
    return Future<[ArticleResponse], Error> { completion in
      if let url = URL(string: _endpoint) {
        AF.request(url)
          .validate()
          .responseDecodable(of: ArticlesResponseOld.self) { response in
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
