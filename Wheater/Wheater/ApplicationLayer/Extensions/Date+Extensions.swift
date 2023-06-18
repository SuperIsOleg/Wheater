//
//  Date+Extensions.swift
//  Wheater
//
//  Created by Oleg Kalistratov on 18.06.23.
//

import Foundation

extension Date {
    func convertToDate(format: String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(secondsFromGMT: 0) // 0 - the number of seconds from GMT.
        return formatter.string(from: self)
    }
    
    static func convertToTime(format: String, identifier: String) -> String? {
         let formatter = DateFormatter()
         formatter.dateFormat = format
         formatter.timeZone = TimeZone(identifier: identifier)
        return formatter.string(from: self.now)
     }
    
    static func getCurrentDate(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self.now)
    }
}
