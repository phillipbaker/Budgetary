//
//  PayeesDataSourceLocal.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

public protocol PayeesDataSourceLocal {
    func payeesStream() async -> AsyncStream<[PayeePlain]>
    func findPayee(by id: String) -> PayeePlain
    func create(payee: PayeePlain)
    func update(payee: PayeePlain)
    func delete(payee: PayeePlain)
}
