//
//  BudgetDao.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

import Dependencies
import Foundation
import SwiftData

class BudgetDao {
    private var container: ModelContainer
    let mapper: BudgetMapperPlain
    
    init(container: ModelContainer, mapper: BudgetMapperPlain) {
        self.container = container
        self.mapper = mapper
    }
    
    @MainActor
    func streamBudget() -> AsyncStream<BudgetPlain> {
        let (stream, continuation) = AsyncStream.makeStream(of: BudgetPlain.self)
        
//        let budget = FetchDescriptor<BudgetDb>()
        
//        do {
//            let results = try container.mainContext.fetch(budget)
//            
//            for result in results {
//                let budgetPlain = mapper.mapDbToPlain(budgetDb: result)
//                continuation.yield(budgetPlain)
//            }
            
            continuation.yield(mapper.mapDbToPlain(budgetDb: .mock))
//        } catch {
//            print(error)
//        }
        return stream
    }
    
    func findBudget(by id: String) -> BudgetDb {
        return .mock
    }
    
    func create(budget: BudgetDb) {
        
    }
    
    func update(budget: BudgetDb) {
        
    }
    
    func delete(budget: BudgetDb) {
        
    }
}
