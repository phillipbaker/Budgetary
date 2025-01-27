//
//  BudgetAccountDao.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

import Dependencies
import Foundation
import SwiftData

class BudgetAccountDao {
    private var container: ModelContainer
    let mapper = BudgetAccountsMapperPlain()
    
    init(container: ModelContainer) {
        self.container = container
    }
    
    @MainActor
    func streamBudgetAccounts() -> AsyncStream<[BudgetAccountPlain]> {
        let (stream, continuation) = AsyncStream.makeStream(of: [BudgetAccountPlain].self)
        continuation.yield(mapper.mapDbToPlain(budgetAccountsDb: .mock))
        return stream
    }
    
    func findBudgetAccount(by id: String) -> BudgetAccountDb {
//        if let budgetAccount = try container.mainContext.fetch(
//            FetchDescriptor<BudgetAccountDb>(predicate: #Predicate { $0.id == id })
//        ).first {
//            return budgetAccount
//        }
        return .hsbcChecking

    }
    
    func create(budgetAccount: BudgetAccountDb) {
        
    }
    
    func update(budgetAccount: BudgetAccountDb) {
        
    }
    
    func delete(budgetAccount: BudgetAccountDb) {
        
    }
}
