//
//  NewPayeeSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 12/06/2025.
//

public protocol NewPayeeSource: Sendable {
    func create(payee: PayeePlain) async
}
