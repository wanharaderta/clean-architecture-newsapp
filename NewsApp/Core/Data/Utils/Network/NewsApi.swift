//
//  NewsApi.swift
//  NewsApp
//
//  Created by Wanhar on 16/02/21.
//

import Foundation

struct API {
  
  static let baseUrl = "http://newsapi.org/v2/top-headlines?country=id"
  
}

protocol Endpoint {
  
  var url: String { get }
  
}

enum Endpoints {
  
  enum Gets: Endpoint {
    case news
    
    public var url: String {
      switch self {
      case .news: return "\(API.baseUrl)&category=technology&apiKey=5dab24aff4f14b57b567608a51f8c256"
      }
    }
  }
}
