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
        await payeesDataSourceLocal.payees()
    }
    
    func allAccounts() async -> [BudgetAccountPlain] {
        await budgetAccountsDataSourceLocal.accounts()
    }

    func allCategoryGroups() async -> [CategoryGroupPlain] {
        await categoryGroupsDataSourceLocal.categoryGroups()
    }

    func update(account: BudgetAccountPlain) async {
        await budgetAccountsDataSourceLocal.update(account: account)
    }
}
