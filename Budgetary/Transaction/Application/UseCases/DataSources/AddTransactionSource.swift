//
//  Untitled.swift
//  Budgetary
//
//  Created by Phillip Baker on 21/05/2025.
//

public protocol AddTransactionSource {
    func create(payee: PayeePlain) async
    func allPayees() async -> [PayeePlain]
    func findPayee(by id: String) async -> PayeePlain?
    func findBudgetAccount(by id: String) async -> BudgetAccountPlain?
    func findCategoryGroup(containing categoryId: String) async -> CategoryGroupPlain?
    func allCategoryGroups() async -> [CategoryGroupPlain]
    func update(categoryGroup: CategoryGroupPlain) async
    func update(account: BudgetAccountPlain) async
}
