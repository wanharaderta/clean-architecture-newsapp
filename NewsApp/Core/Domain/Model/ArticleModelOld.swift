//
//  ArticleModel.swift
//  NewsApp
//
//  Created by Wanhar on 16/02/21.
//

import Foundation

struct ArticleModelOld: Equatable, Identifiable {
  
  let id: String
  let author: String
  let sourceName: String
  let title: String
  let urlToImage: String
  let content: String
  let description: String
  var favorite: Bool = false
}
