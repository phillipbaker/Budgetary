//
//  GetBudgetSourceCombined.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

import AsyncAlgorithms
import Factory

public final class GetBudgetSourceCombined: GetBudgetSource, Sendable {
    let budgetDataSourceLocal: BudgetDataSourceLocal = Container.shared.budgetDataSourceLocal()
    let payeesDataSourceLocal: PayeesDataSourceLocal = Container.shared.payeesDataSourceLocal()
    let budgetAccountsDataSourceLocal: BudgetAccountsDataSourceLocal = Container.shared.budgetAccountsDataSourceLocal()
    let categoryGroupsDataSourceLocal: CategoryGroupsDataSourceLocal = Container.shared.categoryGroupsDataSourceLocal()
    let mapper: CombinedBudgetDataMapper = Container.shared.combinedBudgetDataMapper()

    let (combinedBudgetDataStream, continuation) = AsyncStream.makeStream(of: CombinedBudgetData.self, bufferingPolicy: .bufferingNewest(1))
    
    public init() {
        Task { await startStreaming() }
    }
    
    func startStreaming() async {
        let budgetStream = await budgetDataSourceLocal.budgetStream()
        let payeesStream = await payeesDataSourceLocal.payeesStream()
        let budgetAccountsStream = await budgetAccountsDataSourceLocal.budgetAccountsStream()
        let categoryGroupsStream = await categoryGroupsDataSourceLocal.categoryGroupsStream()
        
        for await ((budgetPlain, payeesPlain, categoryGroupsPlain), budgetAccountsPlain) in combineLatest(combineLatest(budgetStream, payeesStream, categoryGroupsStream), budgetAccountsStream) {
            continuation.yield(mapper.map(
                budgetPlain: budgetPlain,
                payeesPlain: payeesPlain,
                budgetAccountsPlain: budgetAccountsPlain,
                categoryGroupsPlain: categoryGroupsPlain
            ))
        }
        
        continuation.onTermination = { @Sendable reason in
            // Handle any necessary cleanup
            print("combinedStream terminated with reason: ", reason)
        }
    }
    
    public func budgetData() async -> AsyncStream<CombinedBudgetData> {
        return combinedBudgetDataStream
    }
}
