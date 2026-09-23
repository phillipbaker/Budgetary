//
//  CategoryGroupRow.swift
//  Budgetary
//
//  Created by Phillip Baker on 14/08/2024.
//

import Foundation

public struct CategoryGroupRow: Equatable, Hashable, Identifiable, Sendable {
    public let id: ID<CategoryGroupRow>
    let name: String
    let isHidden: Bool
    let assignedTotal: [MonthYear: Decimal]
    let activityTotal: [MonthYear: Decimal]
    let availableTotal: [MonthYear: Decimal]
    let categories: [CategoryRow]
}
