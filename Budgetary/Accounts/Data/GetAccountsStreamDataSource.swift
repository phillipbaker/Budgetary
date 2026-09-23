////
////  AccountsDataSource.swift
////  Budgetary
////
////  Created by Phillip Baker on 04/05/2025.
////
//
//import AsyncAlgorithms
//import Factory
//
//public final class GetAccountsStreamDataSource: GetAccountsStreamSource {
//    let payeesDataSourceLocal: any PayeesDataSourceLocal = Container.shared.payeesDataSourceLocal()
//    let budgetAccountsDataSourceLocal: any BudgetAccountsDataSourceLocal = Container.shared.budgetAccountsDataSourceLocal()
//    let categoryGroupsDataSourceLocal: any CategoryGroupsDataSourceLocal = Container.shared.categoryGroupsDataSourceLocal()
//    
//    let (combinedAccountsDataStream, continuation) = AsyncStream.makeStream(of: CombinedAccountsData.self, bufferingPolicy: .bufferingNewest(1))
//    
//    public init() {
//        Task { await startStreaming() }
//    }
//    
//    public func startStreaming() async {
//        let payeesStream = await payeesDataSourceLocal.broadcaster.subscribe()
//        let budgetAccountsStream = await budgetAccountsDataSourceLocal.broadcaster.subscribe()
//        let categoryGroupsStream = await categoryGroupsDataSourceLocal.broadcaster.subscribe()
//        
//        for await (payeesPlain, categoryGroupsPlain, budgetAccountsPlain) in combineLatest(payeesStream, categoryGroupsStream, budgetAccountsStream) {
//            continuation.yield(
//                CombinedAccountsData(
//                    accounts: budgetAccountsPlain,
//                    categoryGroups: categoryGroupsPlain,
//                    payees: payeesPlain
//                )
//            )
//        }
//
//        continuation.onTermination = { @Sendable reason in
//            // Handle any necessary cleanup
//            print("combinedAccountsDataStream terminated with reason: ", reason)
//        }
//    }
//    
//    public func accountsData() async -> AsyncStream<CombinedAccountsData> {
//        return combinedAccountsDataStream
//    }
//}

public struct CombinedAccountsData: Equatable, Sendable {
    let accounts: [BudgetAccountPlain]
    let categoryGroups: [CategoryGroupPlain]
    let payees: [PayeePlain]
}
