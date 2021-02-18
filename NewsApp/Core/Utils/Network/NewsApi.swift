//
//  NewsApi.swift
//  NewsApp
//
//  Created by Wanhar on 16/02/21.
//

import Foundation

struct API {
  static let baseUrl = "https://newsapi.org/v2/top-headlines?country=id"
}

protocol Endpoint {
  var url: String { get }
}

enum Endpoints {
  enum Gets: Endpoint {
    case news
    public var url: String {
      switch self {
      case .news: return "\(API.baseUrl)&category=technology&apiKey=74231bbed0db4b088bf4b82599488bb2"
      }
    }
  }
}
