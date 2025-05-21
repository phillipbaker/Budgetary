//
//  BudgetAccountDao.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

import Factory
import Foundation
import SwiftData

class BudgetAccountDao {
    private var container: ModelContainer
    let mapper: BudgetAccountsMapperPlain = Container.shared.budgetAccountsMapperPlain()
    
    private let (stream, continuation) = AsyncStream.makeStream(of: [BudgetAccountPlain].self)
    
    init(container: ModelContainer) {
        self.container = container
        startStreaming()
    }
    
    func startStreaming() {
        continuation.yield(mapper.mapDbToPlain(budgetAccountsDb: mock))
    }
    
    func streamBudgetAccounts() -> AsyncStream<[BudgetAccountPlain]> {
        return stream
    }
    
    func allBudgetAccounts() -> [BudgetAccountDb] {
        return mock
    }
    
    func findBudgetAccount(by id: String) -> BudgetAccountDb? {
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
        let newMock = mock.map { $0.id == budgetAccount.id ? budgetAccount : $0 }
        mock = newMock
        continuation.yield(mapper.mapDbToPlain(budgetAccountsDb: mock))
    }
    
    func delete(budgetAccount: BudgetAccountDb) {
        
    }
    
    private var mock: [BudgetAccountDb] = .mock
}
