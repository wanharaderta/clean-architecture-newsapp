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
  
  public typealias Request = String
  public typealias Response = [ArticleResponse]
  
  private let _endpoint: String
  
  public init(endpoint: String) {
    _endpoint = endpoint
  }

  public func execute(request: String?) -> AnyPublisher<[ArticleResponse], Error> {
    return Future<[ArticleResponse], Error> { completion in
      if let url = URL(string: _endpoint) {
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
