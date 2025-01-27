//
//  PayeeDao.swift
//  Budgetary
//
//  Created by Phillip Baker on 05/11/2024.
//

import Dependencies
import Foundation
import SwiftData

enum PayeeDbUpdate {
    case payees([PayeeDb])
    case error(DbError)
}

class PayeeDao {
    private var container: ModelContainer
    let mapper = PayeesMapperPlain()
    
    init(container: ModelContainer) {
        self.container = container
    }
    
    @MainActor
    func streamPayees() -> AsyncStream<[PayeePlain]> {
        let (stream, continuation) = AsyncStream.makeStream(of: [PayeePlain].self)
        
        let payeesPlain = mapper.map(payeesDb: .mock)
        
        continuation.yield(payeesPlain)
        return stream
//        AsyncStream { continuation in
//            Task {
//                let allPayees = FetchDescriptor<PayeeDb>()
                
//                do {
//                    let results = try container.mainContext.fetch(payees)
                    
//                    for result in results {
//                        let budgetPlain = mapper.mapDbToPlain(budgetDb: result)
//                        continuation.yield(budgetPlain)
//                }
                    
//                } catch {
//                    print(error)
//                }
//            }
//        }
    }
    
    func allPayees() -> [PayeeDb] {
//        let allPayees = FetchDescriptor<PayeeDb>()
//        
//        do {
//            let payees = try container.mainContext.fetch(allPayees)
//            continuation.yield(payees)
//        } catch {
//            continuation.yield(.error(DbError.db))
//            throw DbError.db
//        }
        return [
            PayeeDb(
                id: UUID().uuidString,
                name: "Sainsbury’s",
                aliases: [],
                includedInPayeeList: true,
                automaticallyCategorizeIsOn: true,
                defaultCategoryId: "Groceries"
            )
        ]
    }
    
    // Remove try? error do/try/catch
    func findPayee(by id: String) -> PayeeDb {
//        let predicate = #Predicate<PayeeDb> { $0.id == id }
//        let descriptor = FetchDescriptor<PayeeDb>(predicate: predicate)
//        
//        do {
//            guard let payee = try container.mainContext.fetch(descriptor).first else { throw DbError.db }
//            return payee
//        } catch {
//            throw DbError.db
//        }
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
//        container.mainContext.insert(payee)
    }
    
    func update(payee: PayeeDb) {
        
    }
    
    func delete(payee: PayeeDb) {
        
    }
}

enum DbError: Error {
    case db
}
