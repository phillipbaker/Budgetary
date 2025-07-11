//
//  BudgetAccountPreviewData.swift
//  Budgetary
//
//  Created by Phillip Baker on 20/09/2024.
//

import Foundation

extension BudgetAccount {
    static let hsbcChecking = BudgetAccount(
        id: UUID().uuidString,
        name: "HSBC Checking",
        accountType: .budget,
        startingBalance: 0.0,
        notes: nil,
        isClosed: false,
        transactions: .preview
    )
}
