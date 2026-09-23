//
//  BudgetAccountTypePresentation.swift
//  Budgetary
//
//  Created by Phillip Baker on 27/11/2025.
//


public enum BudgetAccountTypePresentation: Equatable, Hashable, Identifiable, Sendable {
    case cash(CashAccountTypePresentation)
    case credit(CreditAccountTypePresentation)

    // Stable identity for use in ForEach and grouping keys
    public var id: String {
        switch self {
        case .cash(let cashAccountType):
            return cashAccountType.rawValue
        case .credit(let creditAccountType):
            return creditAccountType.rawValue
        }
    }
    
    var group: BudgetAccountGroupPresentation {
        switch self {
        case .cash:
            return .cash
        case .credit:
            return .credit
        }
    }
    
    var name: String {
        switch self {
        case .cash(.cash):
            return "Cash"
        case .cash(.checking):
            return "Checking"
        case .cash(.savings):
            return "Savings"
        case .credit(.creditCard):
            return "Credit Card"
        }
    }
}

public enum BudgetAccountGroupPresentation: String, CaseIterable, Hashable, Equatable, Identifiable, Sendable {
    case cash
    case credit
    
    public var id: String { self.rawValue }
}

public enum CashAccountTypePresentation: String, CaseIterable, Hashable, Equatable, Identifiable, Sendable {
    case cash
    case checking
    case savings
    
    public var id: String { self.rawValue }
}

public enum CreditAccountTypePresentation: String, CaseIterable, Hashable, Equatable, Identifiable, Sendable {
    case creditCard
    
    public var id: String { self.rawValue }
}
