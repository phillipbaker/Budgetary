//
//  AccountsLocalDataGateway.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

import Factory

actor BudgetAccountsLocalDataGateway: BudgetAccountsDataSourceLocal {
    let dao: BudgetAccountDao = Container.shared.budgetAccountDao()
    let mapper: BudgetAccountsMapperPlain = Container.shared.budgetAccountsMapperPlain()
    
    private let (stream, continuation) = AsyncStream.makeStream(of: [BudgetAccountPlain].self, bufferingPolicy: .bufferingNewest(1))

    init() {
        Task { await startStreaming() }
    }
    
    func startStreaming() async {
        for await budgetAccountsPlain in dao.streamBudgetAccounts() {
            //            let budgetAccountsPlain = budgetAccountDb.map { budgetAccountDb in
            //                mapper.mapDbToPlain(budgetAccountDb: budgetAccountDb)
            continuation.yield(budgetAccountsPlain)
        }
        
        continuation.onTermination = { @Sendable reason in
            // Handle any necessary cleanup
            print("budgetAccountsPlain gateway stream terminated with reason: ", reason)
        }
    }

    func budgetAccountsStream() async -> AsyncStream<[BudgetAccountPlain]> {
        return stream
    }
    
    func allBudgetAccounts() async -> [BudgetAccountPlain] {
        let budgetAccountsDb = dao.allBudgetAccounts()
        return mapper.mapDbToPlain(budgetAccountsDb: budgetAccountsDb)
    }
    
    func findBudgetAccount(by id: String) -> BudgetAccountPlain? {
        guard let budgetAccountDb = dao.findBudgetAccount(by: id) else { return nil }
        return mapper.mapDbToPlain(budgetAccountDb: budgetAccountDb)
    }
    
    func create(budgetAccount: BudgetAccountPlain) {
        dao.create(budgetAccount: mapper.mapPlainToDb(budgetAccountPlain: budgetAccount))
    }
    
    func update(budgetAccount: BudgetAccountPlain) {
        dao.update(budgetAccount: mapper.mapPlainToDb(budgetAccountPlain: budgetAccount))
    }
    
    func delete(budgetAccount: BudgetAccountPlain) {
        dao.delete(budgetAccount: mapper.mapPlainToDb(budgetAccountPlain: budgetAccount ))
    }
}
