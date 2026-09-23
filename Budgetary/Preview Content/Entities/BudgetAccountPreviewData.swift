//
//  BudgetAccountPreviewData.swift
//  Budgetary
//
//  Created by Phillip Baker on 20/09/2024.
//

import Foundation

extension BudgetAccount {
    static let hsbcChecking = BudgetAccount(
        id: ID<BudgetAccount>(.hsbcChecking),
        name: "HSBC Checking",
        type: .cash(.checking),
        startingBalance: 0.0,
        notes: nil,
        isClosed: false,
        transactions: .preview
    )
}
