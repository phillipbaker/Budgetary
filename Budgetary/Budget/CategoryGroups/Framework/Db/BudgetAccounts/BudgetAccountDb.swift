//
//  BudgetAccountDb.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

import Foundation
import SwiftData

@Model
final class BudgetAccountDb: Equatable {
    #Unique<BudgetAccountDb>([\.id, \.nickname])
    
    var id: String
    var nickname: String
    var accountType: AccountType
    var startingBalance: Decimal
    var notes: String?
    var isClosed: Bool
    @Relationship(deleteRule: .cascade) var transactions: [TransactionDb]
    
    init(
        id: String,
        nickname: String,
        accountType: AccountType,
        startingBalance: Decimal,
        notes: String?,
        isClosed: Bool,
        transactions: [TransactionDb]
    ) {
        self.id = id
        self.nickname = nickname
        self.accountType = accountType
        self.startingBalance = startingBalance
        self.notes = notes
        self.isClosed = isClosed
        self.transactions = transactions
    }
}
