//
//  BudgetsLocalDataGateway.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

import Dependencies

class BudgetLocalDatagateway: BudgetDataSourceLocal {
    var dao: BudgetDao
    var mapper: BudgetMapperPlain
    
    init(dao: BudgetDao, mapper: BudgetMapperPlain) {
        self.dao = dao
        self.mapper = mapper
    }
    
    func budgetStream() async -> AsyncStream<BudgetPlain> {
        let (stream, continuation) = AsyncStream.makeStream(of: BudgetPlain.self)
        
        for await budgetPlain in await dao.streamBudget() {
            //            let budgetPlain = mapper.mapDbToPlain(budgetDb: budgetDb)
            continuation.yield(budgetPlain)
            return stream
        }
        continuation.finish()
        return stream
    }
    
    func findBudget(by id: String) -> BudgetPlain {
        let budgetDb = dao.findBudget(by: id)
        return mapper.mapDbToPlain(budgetDb: budgetDb)
    }
    
    func create(budget: BudgetPlain) {
        dao.create(budget: mapper.mapPlainToDb(budgetPlain: budget))
    }
    
    func update(budget: BudgetPlain) {
        dao.update(budget: mapper.mapPlainToDb(budgetPlain: budget))
    }
    
    func delete(budget: BudgetPlain) {
        dao.delete(budget: mapper.mapPlainToDb(budgetPlain: budget))
    }
}

