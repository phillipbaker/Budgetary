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

    func loadPayees() async -> [PayeePlain] {
        return mapper.map(payeesDb: dao.loadPayees())
    }
    
    func findPayee(by id: ID<PayeePlain>) -> PayeePlain? {
        guard let payeeDb = dao.findPayee(by: id.rawValue) else { return nil }
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
