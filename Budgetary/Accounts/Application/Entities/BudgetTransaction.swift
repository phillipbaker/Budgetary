//
//  BudgetTransaction.swift
//  Budgetary
//
//  Created by Phillip Baker on 23/08/2024.
//

import Foundation

public struct BudgetTransaction: Equatable, Hashable, Sendable {
    let id: ID<BudgetTransaction>
    let date: Date
    let memo: String
    let amount: Amount
    let isCleared: Bool
    let payee: Payee?
    let category: TransactionCategory?
    let account: TransactionAccount
    let linkedTransactionID: ID<BudgetTransaction>? // only when payee type is .transfer
}

extension BudgetTransaction {
    var isInflow: Bool { if case .inflow = amount { true } else { false } }
    var isTransfer: Bool { if case .transfer = payee?.type { true } else { false } }
    
    var isPayment: Bool { isInflow && isTransfer }
    var isRefund: Bool { isInflow && !isTransfer }
}

enum TransactionCategoryType: Equatable {
    case inflow
    case category(TransactionCategory)
    case creditCardPayment
}

enum CategoryType: Equatable {
    case inflow
    case category(CategoryRow)
    case creditCardPayment(CreditCardPaymentRow)
}

enum TransactionCategoryTypePresentation: Equatable {
    case inflow
    case category(TransactionCategoryPresentation)
    case creditCardPayment
}

enum CategoryTypePresentation: Equatable {
    case inflow
    case category(CategoryRowPresentation<CategoryAssignedPresentation, CategoryActivityPresentation, CategoryAvailablePresentation>)
    case creditCardPayment(CreditCardRowPresentation<CreditCardAssignedPresentation, CreditCardActivityPresentation, CreditCardAvailablePresentation>)
}
