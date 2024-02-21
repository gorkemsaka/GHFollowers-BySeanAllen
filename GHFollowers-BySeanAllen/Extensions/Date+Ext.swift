//
//  Date+Ext.swift
//  GHFollowers-BySeanAllen
//
//  Created by Gorkem Saka on 20.02.2024.
//

import Foundation

extension Date {
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
