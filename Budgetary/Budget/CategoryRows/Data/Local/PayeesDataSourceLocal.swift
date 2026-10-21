//
//  PayeesDataSourceLocal.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

public protocol PayeesDataSourceLocal: Sendable {
    func loadPayees() async -> [PayeePlain]
    func findPayee(by id: ID<PayeePlain>) async -> PayeePlain?
    func create(payee: PayeePlain) async
    func update(payee: PayeePlain) async
    func delete(payee: PayeePlain) async
}
