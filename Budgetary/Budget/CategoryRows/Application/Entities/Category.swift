//
//  Category.swift
//  Budgetary
//
//  Created by Phillip Baker on 08/12/2025.
//

import Foundation

public struct Category: Equatable, Hashable, Identifiable, Sendable {
    public let id: ID<Category>
    let name: String
    let notes: String
    let isHidden: Bool
    let assigned: [MonthYear: Decimal]
    
    func updating(assignedAmount: Decimal, for monthYear: MonthYear) -> Category {
        return Category(
            id: self.id,
            name: self.name,
            notes: self.notes,
            isHidden: self.isHidden,
            assigned: self.assigned.merging([monthYear: assignedAmount]) { _, new in new }
        )
    }
}
