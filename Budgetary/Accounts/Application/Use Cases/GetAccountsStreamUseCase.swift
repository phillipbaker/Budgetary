//
//  GetAccountsStreamUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/05/2025.
//

import Factory

public final class GetAccountsStreamUseCase: Sendable {
    let source: GetAccountsStreamSource = Container.shared.getAccountsStreamSource()
    let mapper: BudgetAccountsMapper = Container.shared.budgetAccountsMapper()
    
    func accounts() async -> AsyncStream<[BudgetAccount]> {
        return AsyncStream { continuation in
            Task {
                for await combinedAccountsData in await source.accountsData() {
                    continuation.yield(mapper.mapAccounts(from: combinedAccountsData))
                }
            }
            
            continuation.onTermination = { _ in
                // Cleanup if necessary
            }
        }
    }
}
