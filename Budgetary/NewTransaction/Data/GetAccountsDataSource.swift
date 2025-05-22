//
//  GetAccountsDataSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 21/05/2025.
//

import Factory

final class GetAccountsDataSource: GetAccountsSource {
    let payeesDataSourceLocal: any PayeesDataSourceLocal = Container.shared.payeesDataSourceLocal()
    let budgetAccountsDataSourceLocal: any BudgetAccountsDataSourceLocal = Container.shared.budgetAccountsDataSourceLocal()
    let categoryGroupsDataSourceLocal: any CategoryGroupsDataSourceLocal = Container.shared.categoryGroupsDataSourceLocal()
    
    func accountsData() async -> CombinedAccountsData {
        return CombinedAccountsData(
            accounts: await budgetAccountsDataSourceLocal.allBudgetAccounts(),
            categoryGroups: await categoryGroupsDataSourceLocal.allCategoryGroups(),
            payees: await payeesDataSourceLocal.allPayees()
        )
    }
}
