//
//  GetBudgetSourceCombined.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//
import AsyncAlgorithms

final public class GetBudgetSourceCombined: GetBudgetSource {
    let budgetDataSourceLocal: BudgetDataSourceLocal
    let payeesDataSourceLocal: PayeesDataSourceLocal
    let budgetAccountsDataSourceLocal: BudgetAccountsDataSourceLocal
    let categoryGroupsDataSourceLocal: CategoryGroupsDataSourceLocal
    let mapper: CombinedBudgetDataMapper
    
    let (combinedBudgetDataStream, continuation) = AsyncStream.makeStream(of: CombinedBudgetData.self, bufferingPolicy: .bufferingNewest(1))
    
    public init(
        budgetDataSourceLocal: BudgetDataSourceLocal,
        payeesDataSourceLocal: PayeesDataSourceLocal,
        budgetAccountsDataSourceLocal: BudgetAccountsDataSourceLocal,
        categoryGroupsDataSourceLocal: CategoryGroupsDataSourceLocal,
        mapper: CombinedBudgetDataMapper
    ) {
        self.budgetDataSourceLocal = budgetDataSourceLocal
        self.payeesDataSourceLocal = payeesDataSourceLocal
        self.budgetAccountsDataSourceLocal = budgetAccountsDataSourceLocal
        self.categoryGroupsDataSourceLocal = categoryGroupsDataSourceLocal
        self.mapper = mapper
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
