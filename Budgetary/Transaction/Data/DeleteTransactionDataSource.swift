//
//  DeleteTransactionDataSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 26/05/2025.
//

import Factory

final class DeleteTransactionDataSource: DeleteTransactionSource {
    let budgetAccountsDataSourceLocal: any BudgetAccountsDataSourceLocal = Container.shared.budgetAccountsDataSourceLocal()
    let payeesDataSourceLocal: any PayeesDataSourceLocal = Container.shared.payeesDataSourceLocal()
    let categoryGroupsDataSourceLocal = Container.shared.categoryGroupsDataSourceLocal()

    let mapper: BudgetAccountsMapper = Container.shared.budgetAccountsMapper()

    func loadPayees() async -> [PayeePlain] {
        await payeesDataSourceLocal.loadPayees()
    }
    
    func loadBudgetAccounts() async -> [BudgetAccountPlain] {
        await budgetAccountsDataSourceLocal.loadBudgetAccounts()
    }

    func loadCategoryGroups() async -> [CategoryGroupPlain] {
        await categoryGroupsDataSourceLocal.loadCategoryGroups()
    }

    func update(account: BudgetAccountPlain) async {
        await budgetAccountsDataSourceLocal.update(account: account)
    }
}
