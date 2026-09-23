//
//  Untitled.swift
//  Budgetary
//
//  Created by Phillip Baker on 21/05/2025.
//

public protocol SaveTransactionSource: Sendable {
    func create(payee: PayeePlain) async
    func findAccount(containing: ID<TransactionPlain>) async -> BudgetAccountPlain?
    func allPayees() async -> [PayeePlain]
    func findPayee(by id: ID<PayeePlain>) async -> PayeePlain?
    func findBudgetAccount(by id: ID<BudgetAccountPlain>) async -> BudgetAccountPlain?
    func findCategoryGroup(containing categoryID: ID<CategoryPlain>) async -> CategoryGroupPlain?
    func allCategoryGroups() async -> [CategoryGroupPlain]
    func update(categoryGroup: CategoryGroupPlain) async
    func update(account: BudgetAccountPlain) async
}
