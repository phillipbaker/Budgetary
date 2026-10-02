//
//  MonthYear.swift
//  Budgetary
//
//  Created by Phillip Baker on 25/08/2024.
//

import Foundation

public struct MonthYear: Codable, Identifiable, Sendable {
    public let id: ID<MonthYear>
    let month: Int
    let year: Int
    
    init(
        id: ID<MonthYear> = .init(),
        month: Int,
        year: Int,
        calendar: Calendar = .current
    ) {
        guard month >= 1 && month <= 12 else {
            fatalError("Unable to make date.")
        }
        self.id = id
        self.month = month
        self.year = year
    }
    
    init(from date: Date, in calendar: Calendar = .current) {
        self.id = .init()
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        self.month = month
        self.year = year
    }
    
    mutating func increment() {
        if self.month == 12 {
            self = MonthYear(month: 1, year: self.year.advanced(by: 1))
        } else {
            self = MonthYear(month: self.month.advanced(by: 1), year: self.year)
        }
    }
    
    mutating func decrement() {
        if self.month == 1 {
            self = MonthYear(month: 12, year: self.year.advanced(by: -1))
        } else {
            self = MonthYear(month: self.month.advanced(by: -1), year: self.year)
        }
    }
}

extension MonthYear {
    static var currentMonthYear: MonthYear {
        return MonthYear(
            month: Calendar.current.component(.month, from: .now),
            year: Calendar.current.component(.year, from: .now)
        )
    }
}

extension MonthYear: CustomStringConvertible {
    public var description: String {
        let monthNames = [
            "January", "February", "March", "April", "May", "June",
            "July", "August", "September", "October", "November", "December"
        ]
        return "\(monthNames[month - 1]) \(year)"
    }
    
    var monthWide: String {
        let monthNames = [
            "January", "February", "March", "April", "May", "June",
            "July", "August", "September", "October", "November", "December"
        ]
        
        return "\(monthNames[month - 1])"
    }
    
    var monthAbbreviated: String {
        let monthNames = [
            "Jan", "Feb", "Mar", "Apr", "May", "Jun",
            "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
        ]
        
        return "\(monthNames[month - 1])"
    }
}

extension MonthYear: Equatable, Hashable {
    public static func == (lhs: MonthYear, rhs: MonthYear) -> Bool {
        return lhs.month == rhs.month && lhs.year == rhs.year
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(month)
        hasher.combine(year)
    }
}


// Comparable lets MonthYear dictionary keys be sorted, filtered and
// bounded with .sorted(), .min(), max() and comparisons like `$0.key > monthYear`.
// It enables MonthYear to be used as a range bound. Strideable also requires it.
extension MonthYear: Comparable {
    public static func < (lhs: MonthYear, rhs: MonthYear) -> Bool {
        if lhs.year == rhs.year {
            return lhs.month < rhs.month
        }
        return lhs.year < rhs.year
    }
}

// Strideable lets MonthYear ranges be iterated and used as collections.
// The standard library calls distance(to:) for ClosedRange's count and indexing,
// so it's needed even though we never call it directly.
extension MonthYear: Strideable {
    // Distance in months from this month to another month
    public func distance(to other: MonthYear) -> Int {
        let yearDifference = other.year - self.year
        let monthDifference = other.month - self.month
        return yearDifference * 12 + monthDifference
    }
    
    // Returns a month advanced by a certain number of months
    public func advanced(by n: Int) -> MonthYear {
        let totalMonths = (year * 12 + month) + n
        let newMonth = totalMonths % 12 == 0 ? 12 : totalMonths % 12
        let newYear = (totalMonths - 1) / 12 // Adjust for the case where newMonth is 12
        return MonthYear(month: newMonth, year: newYear)
    }
}
