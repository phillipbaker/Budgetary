//
//  BudgetAccountDb.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

import Foundation
import SwiftData

@Model
final class BudgetAccountDb {    
    @Attribute(.unique) var externalID: UUID
    @Attribute(.unique) var name: String
    var accountType: BudgetAccountTypeDb
    var startingBalance: Decimal
    var notes: String?
    var isClosed: Bool
    @Relationship(deleteRule: .cascade) var transactions: [TransactionDb]
    
    init(
        externalID: UUID,
        name: String,
        accountType: BudgetAccountTypeDb,
        startingBalance: Decimal,
        notes: String?,
        isClosed: Bool,
        transactions: [TransactionDb]
    ) {
        self.externalID = externalID
        self.name = name
        self.accountType = accountType
        self.startingBalance = startingBalance
        self.notes = notes
        self.isClosed = isClosed
        self.transactions = transactions
    }
}
