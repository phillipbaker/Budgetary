//
//  BudgetAccountDetailPresentation.swift
//  Budgetary
//
//  Created by Phillip Baker on 15/05/2025.
//

public struct BudgetAccountDetailPresentation: Equatable, Hashable, Sendable {
    public let id: String
    let name: String
    let balance: String
    let isSelected: Bool
}
