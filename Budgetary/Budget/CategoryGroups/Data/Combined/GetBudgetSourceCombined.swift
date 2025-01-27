//
//  GetBudgetSourceCombined.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

import AsyncAlgorithms
import Dependencies

public class GetBudgetSourceCombined: GetBudgetSource {
    let budgetDataSourceLocal: BudgetDataSourceLocal
    let payeesDataSourceLocal: PayeesDataSourceLocal
    let budgetAccountsDataSourceLocal: BudgetAccountsDataSourceLocal
    let categoryGroupsDataSourceLocal: CategoryGroupsDataSourceLocal
    let mapper: CombinedBudgetDataMapper
    
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
    }
    
    public func budgetData() async -> AsyncStream<CombinedBudgetData> {
        let budgetStream = await budgetDataSourceLocal.budgetStream()
        let payeesStream = await payeesDataSourceLocal.payeesStream()
        let budgetAccountsStream = await budgetAccountsDataSourceLocal.budgetAccountsStream()
        let categoryGroupsStream = await categoryGroupsDataSourceLocal.categoryGroupsStream()
        
        let (combinedBudgetDataStream, continuation) = AsyncStream.makeStream(of: CombinedBudgetData.self)
        
        for await ((budgetPlain, payeesPlain, budgetAccountsPlain), categoryGroupsPlain) in combineLatest(combineLatest(budgetStream, payeesStream, budgetAccountsStream), categoryGroupsStream) {
            continuation.yield(mapper.map(
                budgetPlain: budgetPlain,
                payeesPlain: payeesPlain,
                budgetAccountsPlain: budgetAccountsPlain,
                categoryGroupsPlain: categoryGroupsPlain
            ))
            return combinedBudgetDataStream
        }
        continuation.finish()
        return combinedBudgetDataStream
    }
}
