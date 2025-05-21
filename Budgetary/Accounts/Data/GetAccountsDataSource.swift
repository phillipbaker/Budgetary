//
//  AccountsDataSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/05/2025.
//

import Factory

public final class GetAccountsDataSource: GetAccountsSource {
    let payeesDataSourceLocal: PayeesDataSourceLocal = Container.shared.payeesDataSourceLocal()
    let budgetAccountsDataSourceLocal: BudgetAccountsDataSourceLocal = Container.shared.budgetAccountsDataSourceLocal()
    let categoryGroupsDataSourceLocal: any CategoryGroupsDataSourceLocal = Container.shared.categoryGroupsDataSourceLocal()

    public func getAccountsData() async -> CombinedAccountsData {
        return CombinedAccountsData(
            accounts: await budgetAccountsDataSourceLocal.allBudgetAccounts(),
            categoryGroups: await categoryGroupsDataSourceLocal.allCategoryGroups(),
            payees: await payeesDataSourceLocal.allPayees()
        )
    }
}

public struct CombinedAccountsData: Equatable, Sendable {
    let accounts: [BudgetAccountPlain]
    let categoryGroups: [CategoryGroupPlain]
    let payees: [PayeePlain]
}
