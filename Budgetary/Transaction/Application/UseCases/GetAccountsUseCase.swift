//
//  GetTransactionAccountsUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 21/05/2025.
//

import Factory

final class GetTransactionAccountsUseCase {
    let source: GetAccountsSource = Container.shared.getAccountsSource()
    let mapper: BudgetAccountsMapper = Container.shared.budgetAccountsMapper()
    
    func accounts() async -> [TransactionAccount] {
        let accountsPlain = await source.allAccounts()
        return mapper.map(accounts: accountsPlain)
    }
}
