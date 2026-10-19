//
//  SaveTransactionSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 21/05/2025.
//

public protocol SaveTransactionSource: Sendable {
    func create(payee: PayeePlain) async
    func findBudgetAccount(by id: ID<BudgetAccountPlain>) async -> BudgetAccountPlain?
    func findBudgetAccount(containing: ID<TransactionPlain>) async -> BudgetAccountPlain?
    func findCategoryGroup(containing categoryID: ID<CategoryPlain>) async -> CategoryGroupPlain?
    func findPayee(by id: ID<PayeePlain>) async -> PayeePlain?
    func loadCategoryGroups() async -> [CategoryGroupPlain]
    func loadPayees() async -> [PayeePlain]
    func update(categoryGroup: CategoryGroupPlain) async
    func update(account: BudgetAccountPlain) async
}
