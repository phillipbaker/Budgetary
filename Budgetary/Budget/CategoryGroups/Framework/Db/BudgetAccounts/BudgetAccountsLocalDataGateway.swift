//
//  AccountsLocalDataGateway.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

import Factory

actor BudgetAccountsLocalDataGateway: BudgetAccountsDataSourceLocal {
    typealias BudgetAccountsBroadcaster = StreamBroadcaster<[BudgetAccountPlain]>

    nonisolated var broadcaster: BudgetAccountsBroadcaster {
        return _broadcaster
    }
    
    private let _broadcaster = StreamBroadcaster<[BudgetAccountPlain]>(id: "BudgetAccountsLocalDataGateway")

    let dao: BudgetAccountDao = Container.shared.budgetAccountDao()
    let mapper: BudgetAccountsMapperPlain = Container.shared.budgetAccountsMapperPlain()

    init() {
        Task { await startStreaming() }
    }
    
    private func startStreaming() async {
        for await budgetAccountsPlain in dao.streamBudgetAccounts() {
            await _broadcaster.send(budgetAccountsPlain)
        }
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
