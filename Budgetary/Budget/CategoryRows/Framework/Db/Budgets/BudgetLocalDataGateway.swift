//
//  BudgetLocalDataGateway.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

import Factory

actor BudgetLocalDataGateway: BudgetDataSourceLocal {
    let dao: BudgetDao = Container.shared.budgetDao()
    let mapper: BudgetMapperPlain = Container.shared.budgetMapperPlain()
    
    func findBudget(by id: String) -> BudgetPlain? {
        guard let budgetDb = dao.findBudget(by: id) else {
            return nil
        }
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

