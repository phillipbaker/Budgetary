//
//  BudgetsLocalDataGateway.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

import Dependencies

actor BudgetLocalDatagateway: BudgetDataSourceLocal {
    var dao: BudgetDao
    var mapper: BudgetMapperPlain
    
    private let (stream, continuation) = AsyncStream.makeStream(of: BudgetPlain.self, bufferingPolicy: .bufferingNewest(1))
    
    init(dao: BudgetDao, mapper: BudgetMapperPlain) {
        self.dao = dao
        self.mapper = mapper
        Task { await startStreaming() }
    }
    
    func startStreaming() async {
        for await budgetPlain in dao.streamBudget() {
            //            let budgetPlain = mapper.mapDbToPlain(budgetDb: budgetDb)
            continuation.yield(budgetPlain)
        }
        
        continuation.onTermination = { @Sendable reason in
            // Handle any necessary cleanup
            print("budgets gateway stream terminated with reason: ", reason)
        }
    }
    
    func budgetStream() async -> AsyncStream<BudgetPlain> {
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

