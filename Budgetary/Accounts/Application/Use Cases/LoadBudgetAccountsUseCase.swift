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
    
    func execute() async -> [BudgetAccount] {
        let payeesPlain = await source.payees()
        let accountsPlain = await source.accounts()
        let categoryGroupsPlain = await source.categoryGroups()
        return mapper.map(accounts: accountsPlain, payees: payeesPlain, categoryGroups: categoryGroupsPlain)
    }
}
