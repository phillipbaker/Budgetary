//
//  LoadBudgetAccountsUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 18/01/2026.
//

import Factory

struct LoadBudgetAccountsUseCase: Sendable {
    let source: LoadBudgetAccountsSource
    let mapper: BudgetAccountsMapper
    
    init(
        source: LoadBudgetAccountsSource = Container.shared.loadBudgetAccountsSource(),
        mapper: BudgetAccountsMapper = Container.shared.budgetAccountsMapper()
    ) {
        self.source = source
        self.mapper = mapper
    }
    
    func execute() async -> [BudgetAccount] {
        let payeesPlain = await source.loadPayees()
        let accountsPlain = await source.loadBudgetAccounts()
        let categoryGroupsPlain = await source.loadCategoryGroups()
        return mapper.map(accounts: accountsPlain, payees: payeesPlain, categoryGroups: categoryGroupsPlain)
    }
}
