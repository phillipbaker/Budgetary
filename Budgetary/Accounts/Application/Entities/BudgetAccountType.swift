//
//  BudgetAccountType.swift
//  Budgetary
//
//  Created by Phillip Baker on 12/11/2025.
//

enum BudgetAccountType: Equatable, Hashable, Sendable {
    case cash(CashAccountType)
    case credit(CreditAccountType)
}

enum CashAccountType: String, CaseIterable, Equatable, Identifiable, Sendable {
    case cash
    case checking
    case savings
    
    var id: String { self.rawValue }
}

enum CreditAccountType: String, CaseIterable, Equatable, Identifiable, Sendable {
    case creditCard
    
    var id: String { self.rawValue }
}
