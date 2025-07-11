//
//  AddTransactionDataSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 21/05/2025.
//

import Factory

final class AddTransactionDataSource: AddTransactionSource {
    let budgetAccountsDataSourceLocal: any BudgetAccountsDataSourceLocal = Container.shared.budgetAccountsDataSourceLocal()
    let payeesDataSourceLocal: any PayeesDataSourceLocal = Container.shared.payeesDataSourceLocal()
    let categoryGroupsDataSourceLocal: any CategoryGroupsDataSourceLocal = Container.shared.categoryGroupsDataSourceLocal()
    
    func findBudgetAccount(by id: String) async -> BudgetAccountPlain? {
        await budgetAccountsDataSourceLocal.findBudgetAccount(by: id)
    }
    
    func update(account: BudgetAccountPlain) async {
        await budgetAccountsDataSourceLocal.update(budgetAccount: account)
    }

    func allPayees() async -> [PayeePlain] {
        await payeesDataSourceLocal.allPayees()
    }
    
    func findPayee(by id: String) async -> PayeePlain? {
        await payeesDataSourceLocal.findPayee(by: id)
    }
    
    func create(payee: PayeePlain) async {
        await payeesDataSourceLocal.create(payee: payee)
    }

    func allCategoryGroups() async -> [CategoryGroupPlain] {
        await categoryGroupsDataSourceLocal.allCategoryGroups()
    }
    
    func findCategoryGroup(containing categoryId: String) async -> CategoryGroupPlain? {
        await categoryGroupsDataSourceLocal.findCategoryGroup(containing: categoryId)
    }
    
    func update(categoryGroup: CategoryGroupPlain) async {
        await categoryGroupsDataSourceLocal.update(categoryGroup: categoryGroup)
    }
}
