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
    
    func loadPayees() -> [PayeeDb] {
        return mock
    }
    
    func findPayee(by id: UUID) -> PayeeDb? {
        mock.first(where: { $0.externalID == id })
    }
    
    func create(payee: PayeeDb) {
        let newMock = mock + [payee]
        mock = newMock
        continuation.yield(mapper.map(payeesDb: newMock))
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
