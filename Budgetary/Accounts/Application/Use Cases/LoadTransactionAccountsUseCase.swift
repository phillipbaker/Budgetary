//
//  LoadTransactionAccountsUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 05/02/2026.
//

import Factory

struct LoadTransactionAccountsUseCase: Sendable {
    let source: LoadTransactionAccountsSource
    let mapper: BudgetAccountsMapper
    
    init(
        source: LoadTransactionAccountsSource = Container.shared.loadTransactionAccountsSource(),
        mapper: BudgetAccountsMapper = Container.shared.budgetAccountsMapper()
    ) {
        self.source = source
        self.mapper = mapper
    }
    
    func execute() async -> [TransactionAccount] {
        return mapper.map(accounts: await source.accounts())
    }
}
