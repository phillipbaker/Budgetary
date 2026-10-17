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
        source: LoadBudgetAccountsSource = Container.shared.loadAccountsSource(),
        mapper: BudgetAccountsMapper = Container.shared.budgetAccountsMapper()
    ) {
        self.source = source
        self.mapper = mapper
    }
    
    func execute() async -> [AccountData] {
        let payeesPlain = await source.payees()
        let accountsPlain = await source.accounts()
        let categoryGroupsPlain = await source.categoryGroups()
        let accounts = mapper.map(accounts: accountsPlain, payees: payeesPlain, categoryGroups: categoryGroupsPlain)
        return mapper.map(accounts: accounts)
    }
}
