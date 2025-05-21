//
//  Untitled.swift
//  Budgetary
//
//  Created by Phillip Baker on 21/05/2025.
//

public protocol AddTransactionSource {
    func getPayees() async -> [PayeePlain]
    func getAccounts() async -> [BudgetAccountPlain]
    func getCategoryGroups() async -> [CategoryGroupPlain]
    func update(account: BudgetAccountPlain) async
}
