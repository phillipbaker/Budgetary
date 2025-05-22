//
//  GetBudgetDataSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

import AsyncAlgorithms
import Factory

public final class GetBudgetDataSource: GetBudgetSource {
    let budgetDataSourceLocal: BudgetDataSourceLocal = Container.shared.budgetDataSourceLocal()
    let payeesDataSourceLocal: any PayeesDataSourceLocal = Container.shared.payeesDataSourceLocal()
    let budgetAccountsDataSourceLocal: any BudgetAccountsDataSourceLocal = Container.shared.budgetAccountsDataSourceLocal()
    let categoryGroupsDataSourceLocal: any CategoryGroupsDataSourceLocal = Container.shared.categoryGroupsDataSourceLocal()
    let mapper: BudgetDataMapper = Container.shared.budgetDataMapper()

    let (combinedBudgetDataStream, continuation) = AsyncStream.makeStream(of: CombinedBudgetData.self, bufferingPolicy: .bufferingNewest(1))
    
    public init() {
        Task { await startStreaming() }
    }
    
    func startStreaming() async {
        let budgetStream = await budgetDataSourceLocal.budgetStream()
        let payeesStream = await payeesDataSourceLocal.broadcaster.subscribe()
        let budgetAccountsStream = await budgetAccountsDataSourceLocal.broadcaster.subscribe()
        let categoryGroupsStream = await categoryGroupsDataSourceLocal.broadcaster.subscribe()
        
        for await ((budgetPlain, payeesPlain, categoryGroupsPlain), budgetAccountsPlain) in combineLatest(combineLatest(budgetStream, payeesStream, categoryGroupsStream), budgetAccountsStream) {
            continuation.yield(
                mapper.map(
                    budgetPlain: budgetPlain,
                    payeesPlain: payeesPlain,
                    budgetAccountsPlain: budgetAccountsPlain,
                    categoryGroupsPlain: categoryGroupsPlain
                )
            )
        }
        
        continuation.onTermination = { @Sendable reason in
            // Handle any necessary cleanup
            print("combinedBudgetDataStream terminated with reason: ", reason)
        }
    }
    
    public func budgetData() async -> AsyncStream<CombinedBudgetData> {
        return combinedBudgetDataStream
    }
}
