//
//  UpdateTransactionSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 26/05/2025.
//

public protocol UpdateTransactionSource {
    func findAccount(by id: String) async -> BudgetAccountPlain?
    func allPayees() async -> [PayeePlain]
    func allCategoryGroups() async -> [CategoryGroupPlain]
    func update(account: BudgetAccountPlain) async
}
