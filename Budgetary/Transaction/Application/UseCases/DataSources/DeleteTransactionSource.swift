//
//  DeleteTransactionSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 26/05/2025.
//

public protocol DeleteTransactionSource {
    func loadBudgetAccounts() async -> [BudgetAccountPlain]
    func loadPayees() async -> [PayeePlain]
    func loadCategoryGroups() async -> [CategoryGroupPlain]
    func update(account: BudgetAccountPlain) async
}
