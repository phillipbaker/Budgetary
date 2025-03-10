//
//  PayeesDataSourceLocal.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

public protocol PayeesDataSourceLocal: Sendable {
    func payeesStream() async -> AsyncStream<[PayeePlain]>
    func findPayee(by id: String) async -> PayeePlain
    func create(payee: PayeePlain) async
    func update(payee: PayeePlain) async
    func delete(payee: PayeePlain) async
}
