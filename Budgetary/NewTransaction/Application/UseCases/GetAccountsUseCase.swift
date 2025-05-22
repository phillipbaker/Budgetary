//
//  GetAccountsUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 21/05/2025.
//

import Factory

final class GetAccountsUseCase {
    let source: GetAccountsSource = Container.shared.getAccountsSource()
    let mapper: BudgetAccountsMapper = Container.shared.budgetAccountsMapper()
    
    func accounts() async -> [BudgetAccount] {
        let combinedAccountsData = await source.accountsData()
        return mapper.mapAccounts(from: combinedAccountsData)
    }        
}
