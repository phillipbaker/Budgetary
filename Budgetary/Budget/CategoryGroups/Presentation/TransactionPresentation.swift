//
//  TransactionPresentation.swift
//  Budgetary
//
//  Created by Phillip Baker on 22/11/2024.
//

public struct TransactionPresentation: Equatable, Identifiable {
    public let id: String
    let date: String
    let payee: PayeePresentation?
    let category: TransactionCategoryPresentation
    let memo: String
    let amount: AmountPresentation
    let isCleared: Bool
}

public enum AmountPresentation: Equatable, Sendable {
    case inflow(String)
    case outflow(String)
    
    var value: String {
        switch self {
        case let .inflow(amount):
            return amount
        case let .outflow(amount):
            return amount
        }
    }
}
