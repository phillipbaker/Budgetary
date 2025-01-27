//
//  AccountsLocalDataGateway.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

import Dependencies

class BudgetAccountsLocalDataGateway: BudgetAccountsDataSourceLocal {
    var dao: BudgetAccountDao
    var mapper: BudgetAccountsMapperPlain

    init(dao: BudgetAccountDao, mapper: BudgetAccountsMapperPlain) {
        self.dao = dao
        self.mapper = mapper
    }

    func budgetAccountsStream() async -> AsyncStream<[BudgetAccountPlain]> {
        let (stream, continuation) = AsyncStream.makeStream(of: [BudgetAccountPlain].self)
        for await budgetAccountsPlain in await dao.streamBudgetAccounts() {
            //            let budgetAccountsPlain = budgetAccountDb.map { budgetAccountDb in
            //                mapper.mapDbToPlain(budgetAccountDb: budgetAccountDb)
            continuation.yield(budgetAccountsPlain)
            return stream
        }
        continuation.finish()
        return stream
    }
    
    func findBudgetAccount(by id: String) -> BudgetAccountPlain {
        let budgetAccountDb = dao.findBudgetAccount(by: id)
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
