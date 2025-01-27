//
//  Category.swift
//  Budgetary
//
//  Created by Phillip Baker on 14/08/2024.
//

import Foundation

public struct Category: Equatable, Hashable, Identifiable, Sendable {
    public let id: String
    let name: String
    let notes: String
    let isHidden: Bool
    let assigned: [MonthYear: Assigned]
    let activity: [MonthYear: Activity]
    let available: [MonthYear: Available]
}
