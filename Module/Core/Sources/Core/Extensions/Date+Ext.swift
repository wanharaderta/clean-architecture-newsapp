//
//  File.swift
//  
//
//  Created by Wanhar on 24/02/21.
//

import Foundation

extension Date {
   public func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
