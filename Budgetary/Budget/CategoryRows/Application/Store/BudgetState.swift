//
//  BudgetState.swift
//  Budgetary
//
//  Created by Phillip Baker on 19/01/2026.
//

enum BudgetState: Sendable {
    case notLoaded
    case loading
    case error(BudgetError)
    case loaded(BudgetData)
}

extension BudgetState {
    var isIdle: Bool {
        switch self {
        case .notLoaded, .error:
            return true
        case .loading, .loaded:
            return false
        }
    }
    
    var categoryGroupRowsState: CategoryGroupRowsState {
        switch self {
        case .notLoaded:
            return .notLoaded
        case .loading:
            return .loading
        case .error:
            return .error
        case .loaded(let budget):
            return .loaded(budget.categoryGroups)
        }
    }

    var description: String {
        switch self {
        case .notLoaded:
            "Not Loaded"
        case .loading:
            "Loading"
        case .error(_):
            "Error"
        case .loaded(_):
            "Loaded"
        }
    }
}
