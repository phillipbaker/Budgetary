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
    
    func accounts() async -> [BudgetAccountPlain] {
        let budgetAccountsDb = dao.allBudgetAccounts()
        return mapper.mapDbToPlain(budgetAccountsDb: budgetAccountsDb)
    }
    
    func findAccount(by id: ID<BudgetAccountPlain>) -> BudgetAccountPlain? {
        guard let budgetAccountDb = dao.findBudgetAccount(by: ID<BudgetAccountDb>(id)) else { return nil }
        return mapper.mapDbToPlain(budgetAccountDb: budgetAccountDb)
    }
    
    func findAccount(containing id: ID<TransactionPlain>) async -> BudgetAccountPlain? {
        guard let budgetAccountDb = dao.findBudgetAccount(containing: ID<TransactionDb>(id)) else { return nil }
        return mapper.mapDbToPlain(budgetAccountDb: budgetAccountDb)
    }
    
    func create(account: BudgetAccountPlain) {
        dao.create(account: mapper.mapPlainToDb(budgetAccountPlain: account))
    }
    
    func update(account: BudgetAccountPlain) {
        dao.update(account: mapper.mapPlainToDb(budgetAccountPlain: account))
    }
    
    func delete(account: BudgetAccountPlain) {
        dao.delete(account: mapper.mapPlainToDb(budgetAccountPlain: account ))
    }
}
