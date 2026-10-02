//
//  Array+BudgetTransaction.swift
//  Budgetary
//
//  Created by Phillip Baker on 05/12/2025.
//

import Foundation

extension Array where Element == BudgetTransaction {
    func filtered(by monthYear: MonthYear) -> [BudgetTransaction] {
        return self.filter { MonthYear(from: $0.date) == monthYear }
    }

    func filtered(byAccount accountID: UUID) -> [BudgetTransaction] {
        self.filter { $0.account.id == ID<TransactionAccount>(accountID) }
    }

    func filtered(by id: ID<Category>) -> [BudgetTransaction] {
        return self.filter { $0.category?.id == ID<TransactionCategory>(id) }
    }
    
    func filtered(by id: ID<CategoryPlain>) -> [BudgetTransaction] {
        return self.filter { $0.category?.id == ID<TransactionCategory>(id) }
    }

    var filteredByTransfers: [BudgetTransaction] {
        self.filter {
            switch $0.payee?.type {
            case .regular: return false
            case .transfer: return true
            case .none: return false
            }
        }
    }
    
    var filteredBySpending: [BudgetTransaction] {
        self.filter {
            switch $0.payee?.type {
            case .regular: return true
            case .transfer: return false
            case .none: return true
            }
        }
    }
    
    var filteredByInflows: [BudgetTransaction] {
        self.filter {
            switch $0.amount {
            case .outflow: return false
            case .inflow: return true
            }
        }
    }
    
    var filteredByOutflows: [BudgetTransaction] {
        self.filter {
            switch $0.amount {
            case .outflow: return true
            case .inflow: return false
            }
        }
    }
    
    var mappedToAmounts: [Decimal] {
        self.compactMap { $0.amount.value }
    }
}
