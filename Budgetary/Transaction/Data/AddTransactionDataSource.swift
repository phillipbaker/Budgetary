//
//  AddTransactionDataSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 21/05/2025.
//

import Factory

final class AddTransactionDataSource: SaveTransactionSource {
    let budgetAccountsDataSourceLocal: any BudgetAccountsDataSourceLocal = Container.shared.budgetAccountsDataSourceLocal()
    let payeesDataSourceLocal: any PayeesDataSourceLocal = Container.shared.payeesDataSourceLocal()
    let categoryGroupsDataSourceLocal: any CategoryGroupsDataSourceLocal = Container.shared.categoryGroupsDataSourceLocal()
    
    func findBudgetAccount(by id: ID<BudgetAccountPlain>) async -> BudgetAccountPlain? {
        await budgetAccountsDataSourceLocal.findAccount(by: id)
    }
    
    func findAccount(containing transactionID: ID<TransactionPlain>) async -> BudgetAccountPlain? {
        await budgetAccountsDataSourceLocal.findAccount(containing: transactionID)
    }
    
    func update(account: BudgetAccountPlain) async {
        await budgetAccountsDataSourceLocal.update(account: account)
    }

    func allPayees() async -> [PayeePlain] {
        await payeesDataSourceLocal.payees()
    }
    
    func findPayee(by id: ID<PayeePlain>) async -> PayeePlain? {
        await payeesDataSourceLocal.findPayee(by: id)
    }
    
    func create(payee: PayeePlain) async {
        await payeesDataSourceLocal.create(payee: payee)
    }

    func allCategoryGroups() async -> [CategoryGroupPlain] {
        await categoryGroupsDataSourceLocal.categoryGroups()
    }
    
    func findCategoryGroup(containing categoryID: ID<CategoryPlain>) async -> CategoryGroupPlain? {
        await categoryGroupsDataSourceLocal.findCategoryGroup(containing: categoryID)
    }
    
    func update(categoryGroup: CategoryGroupPlain) async {
        await categoryGroupsDataSourceLocal.update(categoryGroup: categoryGroup)
    }
}
