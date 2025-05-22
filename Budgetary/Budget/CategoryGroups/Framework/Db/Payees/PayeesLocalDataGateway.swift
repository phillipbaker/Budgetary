//
//  PayeesLocalDataGateway.swift
//  Budgetary
//
//  Created by Phillip Baker on 05/11/2024.
//

import Factory

actor PayeesLocalDataGateway: PayeesDataSourceLocal {
    typealias PayeesBroadcaster = StreamBroadcaster<[PayeePlain]>

    nonisolated var broadcaster: PayeesBroadcaster {
        return _broadcaster
    }
    
    private let _broadcaster = StreamBroadcaster<[PayeePlain]>(id: "PayeesLocalDataGateway")

    let dao: PayeeDao = Container.shared.payeeDao()
    let mapper: PayeesMapperPlain = Container.shared.payeesMapperPlain()

    init() {
        Task { await startStreaming() }
    }
    
    func startStreaming() async {
        for await payeesPlain in dao.streamPayees() {
            await _broadcaster.send(payeesPlain)
        }
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
