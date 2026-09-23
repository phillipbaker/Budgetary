//
//  Array+TransactionPlain.swift
//  Budgetary
//
//  Created by Phillip Baker on 05/12/2025.
//

import Foundation

extension Array where Element == TransactionPlain {
    func filtered(by monthYear: MonthYear) -> [TransactionPlain] {
        return self.filter { MonthYear(from: $0.date) == monthYear }
    }
    
    func filtered(by id: ID<CategoryPlain>) -> [TransactionPlain] {
        return self.filter { $0.categoryID == id }
    }
    
    func filtered(by id: ID<Category>) -> [TransactionPlain] {
        return self.filter { $0.categoryID == ID<CategoryPlain>(id) }
    }

    var filteredByInflows: [TransactionPlain] {
        self.filter {
            switch $0.amount {
            case .outflow: return false
            case .inflow: return true
            }
        }
    }

    var filteredByOutflows: [TransactionPlain] {
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
