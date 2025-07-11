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

    func allPayees() async -> [PayeePlain] {
        await payeesDataSourceLocal.allPayees()
    }
    
    func allAccounts() async -> [BudgetAccountPlain] {
        await budgetAccountsDataSourceLocal.allBudgetAccounts()
    }

    func allCategoryGroups() async -> [CategoryGroupPlain] {
        await categoryGroupsDataSourceLocal.allCategoryGroups()
    }

    func update(account: BudgetAccountPlain) async {
        await budgetAccountsDataSourceLocal.update(budgetAccount: account)
    }
}
