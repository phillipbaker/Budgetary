//
//  Int+MonthYear.swift
//  Budgetary
//
//  Created by Phillip Baker on 24/10/2024.
//

import Foundation

extension Int {
    static var currentMonth: Int {
        return MonthYear.currentMonthYear.month
    }
    
    static var currentYear: Int {
        return MonthYear.currentMonthYear.year
    }
    
    static func month(from date: Date) -> Int {
        return MonthYear(from: date).month
    }
    
    static func year(from date: Date) -> Int {
        return MonthYear(from: date).year
    }
}
