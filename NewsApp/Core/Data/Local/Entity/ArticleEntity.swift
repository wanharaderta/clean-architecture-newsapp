//
//  ArticleEntity.swift
//  NewsApp
//
//  Created by Wanhar on 18/02/21.
//

import Foundation
import RealmSwift

class ArticleEntity: Object {
  @objc dynamic var id = ""
  @objc dynamic var author = ""
  @objc dynamic var sourceName = ""
  @objc dynamic var title = ""
  @objc dynamic var urlToImage = ""
  @objc dynamic var content = ""
  @objc dynamic var desc = ""
  @objc dynamic var favorite = false
  
  override class func primaryKey() -> String? {
    return "id"
  }
}
