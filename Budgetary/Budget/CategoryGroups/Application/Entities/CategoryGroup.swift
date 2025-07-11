//
//  CategoryGroup.swift
//  Budgetary
//
//  Created by Phillip Baker on 14/08/2024.
//

import Foundation

public struct CategoryGroup: Equatable, Identifiable, Sendable {
    public let id: String
    let name: String
    let isHidden: Bool
    let assignedTotal: [MonthYear: Decimal]
    let activityTotal: [MonthYear: Decimal]
    let availableTotal: [MonthYear: Decimal]
    let categories: [Category]
}

public struct CategoryGroupEntity: Equatable, Identifiable, Sendable {
    public let id: String
    let name: String
    let isHidden: Bool
    let assignedTotal: [MonthYear: Decimal]
    let categories: [CategoryEntity]
}

public struct CategoryEntity: Equatable, Identifiable, Sendable {
    public let id: String
    let name: String
    let notes: String
    let isHidden: Bool
    let assigned: [MonthYear: Decimal]
}
