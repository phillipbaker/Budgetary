//
//  CategoryGroupPresentation.swift
//  Budgetary
//
//  Created by Phillip Baker on 25/10/2024.
//

import Foundation

public struct CategoryGroupPresentation: BudgetGroupPresentation, Equatable, Identifiable {
    public typealias CategoryRow = CategoryRowPresentation

    public let id: ID<CategoryGroupPresentation>
    public let name: String
    public let isHidden: Bool
    public let assignedTotal: [MonthYear: String]
    public let activityTotal: [MonthYear: String]
    public let availableTotal: [MonthYear: String]
    public let categories: [CategoryRow<CategoryAssignedPresentation, CategoryActivityPresentation, CategoryAvailablePresentation>]
}

public struct CategoryGroupMonthPresentation: BudgetMonthGroupPresentation, Equatable, Identifiable {
    public typealias CategoryMonthRow = CategoryMonthRowPresentation

    public let id: ID<CategoryGroupPresentation>
    public let name: String
    public let isHidden: Bool
    public let assignedTotal: String
    public let activityTotal: String
    public let availableTotal: String
    public let categories: [CategoryMonthRow<CategoryAssignedPresentation, CategoryActivityPresentation, CategoryAvailablePresentation>]
}
