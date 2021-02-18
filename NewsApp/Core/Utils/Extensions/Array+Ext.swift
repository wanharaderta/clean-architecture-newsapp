//
//  Array.swift
//  NewsApp
//
//  Created by Wanhar on 18/02/21.
//

import RealmSwift

extension Results {

  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }

}
