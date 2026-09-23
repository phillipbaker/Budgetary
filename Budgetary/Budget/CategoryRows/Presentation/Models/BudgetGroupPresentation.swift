//
//  BudgetGroupPresentation.swift
//  Budgetary
//
//  Created by Phillip Baker on 03/12/2025.
//

public protocol BudgetGroupPresentation: Equatable, Identifiable, Sendable {
    associatedtype RowPresentation: BudgetRowPresentation
    associatedtype Identity: Hashable
    
    var id: Identity { get }
    var name: String { get }
    var isHidden: Bool { get }
    var assignedTotal: [MonthYear: String] { get }
    var activityTotal: [MonthYear: String] { get }
    var availableTotal: [MonthYear: String] { get }
    var categories: [RowPresentation] { get }
}

public protocol BudgetMonthGroupPresentation: Equatable, Identifiable, Sendable {
    associatedtype MonthRowPresentation: BudgetMonthRowPresentation
    associatedtype Identity: Hashable
    
    var id: Identity { get }
    var name: String { get }
    var isHidden: Bool { get }
    var assignedTotal: String { get }
    var activityTotal: String { get }
    var availableTotal: String { get }
    var categories: [MonthRowPresentation] { get }
}
