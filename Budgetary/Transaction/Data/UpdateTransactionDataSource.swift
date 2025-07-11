//
//  UpdateTransactionDataSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 26/05/2025.
//

import Factory

final class UpdateTransactionDataSource: UpdateTransactionSource {    
    let budgetAccountDataSourceLocal: any BudgetAccountsDataSourceLocal = Container.shared.budgetAccountsDataSourceLocal()
    let payeesDataSourceLocal: any PayeesDataSourceLocal = Container.shared.payeesDataSourceLocal()
    let categoryGroupsDataSourceLocal = Container.shared.categoryGroupsDataSourceLocal()
    let mapper: BudgetAccountsMapper = Container.shared.budgetAccountsMapper()

    func findAccount(by id: String) async -> BudgetAccountPlain? {
        await budgetAccountDataSourceLocal.findBudgetAccount(by: id)
    }
    
    func allPayees() async -> [PayeePlain] {
        await payeesDataSourceLocal.allPayees()
    }
    
    func allCategoryGroups() async -> [CategoryGroupPlain] {
        await categoryGroupsDataSourceLocal.allCategoryGroups()
    }
    
    func update(account: BudgetAccountPlain) async {
        await budgetAccountDataSourceLocal.update(budgetAccount: account)
    }
}
