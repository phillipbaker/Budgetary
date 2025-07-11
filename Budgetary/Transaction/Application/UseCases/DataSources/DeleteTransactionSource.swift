//
//  DeleteTransactionSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 26/05/2025.
//

public protocol DeleteTransactionSource {
    func allAccounts() async -> [BudgetAccountPlain]
    func allPayees() async -> [PayeePlain]
    func allCategoryGroups() async -> [CategoryGroupPlain]
    func update(account: BudgetAccountPlain) async
}
