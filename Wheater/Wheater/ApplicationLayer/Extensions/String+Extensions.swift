//
//  String+Extensions.swift
//  Wheater
//
//  Created by Oleg Kalistratov on 19.06.23.
//

import UIKit

extension String {
    func convertDate(from inputFormat: String, to outputFormat: String,
                     inputTimezone: TimeZone? = TimeZone(secondsFromGMT: 0),
                     outputTimezone: TimeZone? = .current) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = inputFormat
        inputFormatter.timeZone = inputTimezone
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = outputFormat
        outputFormatter.timeZone = outputTimezone
        guard let inputDate = inputFormatter.date(from: self) else { return "error" }
        return outputFormatter.string(from: inputDate)
    }
}
