//
//  PayeeDao.swift
//  Budgetary
//
//  Created by Phillip Baker on 05/11/2024.
//

import Factory
import Foundation
import SwiftData

enum PayeeDbUpdate {
    case payees([PayeeDb])
    case error(DbError)
}

class PayeeDao {
    private var container: ModelContainer
    let mapper: PayeesMapperPlain = Container.shared.payeesMapperPlain()
    
    private let (stream, continuation) = AsyncStream.makeStream(of: [PayeePlain].self)
    
    init(container: ModelContainer) {
        self.container = container
        startStreaming()
    }
    
    func startStreaming() {
        continuation.yield(mapper.map(payeesDb: mock))
    }
    
    func streamPayees() -> AsyncStream<[PayeePlain]> {
        return stream
    }
    
    func allPayees() -> [PayeeDb] {
        return mock
    }
    
    // Remove try? error do/try/catch
    func findPayee(by id: String) -> PayeeDb {
        return PayeeDb(
            id: UUID().uuidString,
            name: "Sainsbury’s",
            aliases: [],
            includedInPayeeList: true,
            automaticallyCategorizeIsOn: true,
            defaultCategoryId: "Groceries"
        )
    }
    
    func create(payee: PayeeDb) {
        // validations not duping etc here?
        mock.append(payee)
    }
    
    func update(payee: PayeeDb) {
        
    }
    
    func delete(payee: PayeeDb) {
        
    }
    
    private var mock: [PayeeDb] = .mock
}

enum DbError: Error {
    case db
}
