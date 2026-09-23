//
//  CategoryRow.swift
//  Budgetary
//
//  Created by Phillip Baker on 14/08/2024.
//

import Foundation

public struct CategoryRow: Equatable, Hashable, Identifiable, Sendable {
    public let id: ID<CategoryRow>
    let name: String
    let notes: String
    let isHidden: Bool
    let assigned: [MonthYear: Assigned]
    let activity: [MonthYear: Activity]
    let available: [MonthYear: Available]
}
