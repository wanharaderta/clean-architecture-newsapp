//
//  Realm+Ext.swift
//  NewsApp
//
//  Created by Wanhar on 20/02/21.
//

import RealmSwift

extension Realm {
    public func safeWrite(_ block: (() throws -> Void)) throws {
        if isInWriteTransaction {
            try block()
        } else {
            try write(block)
        }
    }
}
