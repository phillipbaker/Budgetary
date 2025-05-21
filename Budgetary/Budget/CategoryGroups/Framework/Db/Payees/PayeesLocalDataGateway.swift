//
//  PayeesLocalDataGateway.swift
//  Budgetary
//
//  Created by Phillip Baker on 05/11/2024.
//

import Factory

actor PayeesLocalDataGateway: PayeesDataSourceLocal {
    let dao: PayeeDao = Container.shared.payeeDao()
    let mapper: PayeesMapperPlain = Container.shared.payeesMapperPlain()
    
    private let (stream, continuation) = AsyncStream.makeStream(of: [PayeePlain].self, bufferingPolicy: .bufferingNewest(1))
    
    init() {
        Task { await startStreaming() }
    }
    
    func startStreaming() async {
        for await payeesPlain in dao.streamPayees() {
            //            let payeesPlain = payeesDb.map { payeeDb in
            //                self.mapper.map(payeeDb: payeeDb)
            //            }
            continuation.yield(payeesPlain)
        }
        
        continuation.onTermination = { @Sendable reason in
            // Handle any necessary cleanup
            print("payees gateway stream terminated with reason: ", reason)
        }
    }
    
    func payeesStream() async -> AsyncStream<[PayeePlain]> {
        return stream
    }
    
    func allPayees() async -> [PayeePlain] {
        return mapper.map(payeesDb: dao.allPayees())
    }
    
    func findPayee(by id: String) -> PayeePlain? {
        let payeeDb = dao.findPayee(by: id)
        return mapper.map(payeeDb: payeeDb)
    }
    
    func create(payee: PayeePlain) {
        dao.create(payee: mapper.map(payeePlain: payee))
    }
    
    func update(payee: PayeePlain) {
        dao.update(payee: mapper.map(payeePlain: payee))
    }
    
    func delete(payee: PayeePlain) {
        dao.delete(payee: mapper.map(payeePlain: payee))
    }
}
