//
//  Date+Ext.swift
//  NewsApp
//
//  Created by Wanhar on 18/02/21.
//

import Foundation

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
