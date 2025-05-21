//
//  Payee.swift
//  Budgetary
//
//  Created by Phillip Baker on 25/08/2024.
//

public struct Payee: Equatable, Hashable, Sendable {
    let id: String
    let name: String
    let aliases: [String]
    let includedInPayeeList: Bool
    let automaticallyCategorizeIsOn: Bool
    let defaultCategory: TransactionCategory?
}
