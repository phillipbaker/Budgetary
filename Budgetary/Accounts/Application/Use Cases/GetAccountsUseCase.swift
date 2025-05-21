//
//  GetAccountsUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/05/2025.
//

import Factory

public final class GetAccountsUseCase: Sendable {
    let source: GetAccountsSource = Container.shared.getAccountsSource()
    let mapper: BudgetAccountsMapper = Container.shared.budgetAccountsMapper()
    
    func getAccounts() async -> [BudgetAccount] {
        let combinedAccountsData = await source.getAccountsData()
        return mapper.mapAccounts(from: combinedAccountsData)
    }
}
