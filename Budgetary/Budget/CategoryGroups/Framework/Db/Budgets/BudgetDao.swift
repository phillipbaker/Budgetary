//
//  BudgetDao.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

import Factory
import Foundation
import SwiftData

class BudgetDao {
    private var container: ModelContainer
    let mapper: BudgetMapperPlain = Container.shared.budgetMapperPlain()
    
    private let (stream, continuation) = AsyncStream.makeStream(of: BudgetPlain.self)
    
    init(container: ModelContainer) {
        self.container = container
        startStreaming()
    }
    
    func startStreaming() {
        continuation.yield(mapper.mapDbToPlain(budgetDb: mock))
    }

    func streamBudget() -> AsyncStream<BudgetPlain> {
        return stream
    }
    
    func findBudget(by id: String) -> BudgetDb {
        return mock
    }
    
    func create(budget: BudgetDb) {
        
    }
    
    func update(budget: BudgetDb) {
        
    }
    
    func delete(budget: BudgetDb) {
        
    }
    
    private var mock: BudgetDb = .mock
}
