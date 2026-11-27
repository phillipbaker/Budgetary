//
//  Available.swift
//  Budgetary
//
//  Created by Phillip Baker on 19/11/2024.
//

import Foundation

public struct Available: Equatable, Hashable, Sendable {
    // Stored
    let cashFromLastMonth: Decimal           // last month's balance, if it was positive
    let assignedThisMonth: Decimal
    let cashActivityThisMonth: Decimal       // signed: spending negative, refunds positive
    let creditActivityThisMonth: Decimal     // signed: spending negative, refunds positive
    let message: String
    
    // Derived
    var activityThisMonth: Decimal { cashActivityThisMonth + creditActivityThisMonth }
    var total: Decimal { cashFromLastMonth + assignedThisMonth + activityThisMonth }
    
    /// The shortfall taken from Ready to Assign next month. Cash is funded first,
    /// and a net card refund still counts towards covering it.
    var cashOverspending: Decimal {
        max(-(cashFromLastMonth + assignedThisMonth + cashActivityThisMonth + max(creditActivityThisMonth, 0)), 0)
    }
    
    /// The shortfall that stays as card debt, with nothing set aside for it.
    var creditOverspending: Decimal { max(-total, 0) - cashOverspending }
}
