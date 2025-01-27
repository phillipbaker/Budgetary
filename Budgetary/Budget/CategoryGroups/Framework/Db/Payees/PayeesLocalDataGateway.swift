//
//  PayeesLocalDataGateway.swift
//  Budgetary
//
//  Created by Phillip Baker on 05/11/2024.
//

import Dependencies

class PayeesLocalDataGateway: PayeesDataSourceLocal {
    var dao: PayeeDao
    var mapper: PayeesMapperPlain
    
    init(dao: PayeeDao, mapper: PayeesMapperPlain) {
        self.dao = dao
        self.mapper = mapper
    }
    
    func payeesStream() async -> AsyncStream<[PayeePlain]> {
        let (stream, continuation) = AsyncStream.makeStream(of: [PayeePlain].self)
        for await payeesPlain in await dao.streamPayees() {
//            let payeesPlain = payeesDb.map { payeeDb in
//                self.mapper.map(payeeDb: payeeDb)
//            }
            continuation.yield(payeesPlain)
            return stream
        }
        continuation.finish()
        return stream
    }
    
    func findPayee(by id: String) -> PayeePlain {
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
