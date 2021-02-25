//
//  File.swift
//  
//
//  Created by Wanhar on 24/02/21.
//

import Foundation

public struct ArticleModel: Equatable, Identifiable {
  
  public let id: String
  public let author: String
  public let sourceName: String
  public let title: String
  public let urlToImage: String
  public let content: String
  public let description: String
  public var favorite: Bool = false
  
  public init(
    id: String,
    author: String,
    sourceName: String,
    title: String,
    urlToImage: String,
    content: String,
    description: String,
    favorite: Bool
  ){
    self.id = id
    self.author = author
    self.sourceName = sourceName
    self.title = title
    self.urlToImage = urlToImage
    self.content = content
    self.description = description
    self.favorite = favorite
  }
}
