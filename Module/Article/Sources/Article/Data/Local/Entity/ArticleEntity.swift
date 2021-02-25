//
//  File.swift
//  
//
//  Created by Wanhar on 24/02/21.
//

import Foundation
import RealmSwift

public class ArticleEntity: Object {
  @objc dynamic var itemId = ""
  @objc dynamic var author = ""
  @objc dynamic var sourceName = ""
  @objc dynamic var title = ""
  @objc dynamic var urlToImage = ""
  @objc dynamic var content = ""
  @objc dynamic var desc = ""
  @objc dynamic var favorite = false
  
  public override class func primaryKey() -> String? {
    return "itemId"
  }
}


