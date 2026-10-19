//
//  LoadBudgetDataSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 13/01/2026.
//

import Factory

public final class LoadBudgetDataSource: LoadBudgetSource {
    let budgetDataSourceLocal: BudgetDataSourceLocal = Container.shared.budgetDataSourceLocal()
    let payeesDataSourceLocal: any PayeesDataSourceLocal = Container.shared.payeesDataSourceLocal()
    let budgetAccountsDataSourceLocal: any BudgetAccountsDataSourceLocal = Container.shared.budgetAccountsDataSourceLocal()
    let categoryGroupsDataSourceLocal: any CategoryGroupsDataSourceLocal = Container.shared.categoryGroupsDataSourceLocal()
    let creditCardPaymentGroupDataSourceLocal: any CreditCardPaymentGroupDataSourceLocal = Container.shared.creditCardPaymentGroupDataSourceLocal()
    let mapper: BudgetDataMapper = Container.shared.budgetDataMapper()

    public func loadBudgetData() async throws -> BudgetDataPlain {
        guard let budget = await budgetDataSourceLocal.findBudget(by: "") else {
            throw BudgetError.budgetLoadFailed
        }
        let payees = await payeesDataSourceLocal.loadPayees()
        let budgetAccounts = await budgetAccountsDataSourceLocal.loadBudgetAccounts()
        let categoryGroups = await categoryGroupsDataSourceLocal.loadCategoryGroups()
        let creditCardPaymentGroupPlain = await creditCardPaymentGroupDataSourceLocal.loadCreditCardPaymentGroup()

        return mapper.map(
            budgetPlain: budget,
            payeesPlain: payees,
            budgetAccountsPlain: budgetAccounts,
            categoryGroupsPlain: categoryGroups,
            creditCardPaymentGroupPlain: creditCardPaymentGroupPlain
        )
    }
}
