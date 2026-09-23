//
//  TransactionStateData.swift
//  Budgetary
//
//  Created by Phillip Baker on 19/01/2026.
//

import Foundation

public struct TransactionStateData: Equatable, Hashable, Sendable {
    var transactionToEdit: TransactionData?
//    var pickerState: PickerState?
    var isNewTransaction: Bool
}

public enum PickerState: Equatable, Hashable, Sendable {
    case categoryPicker
    case payeePicker
    case accountPicker
}

public struct TransactionData: Equatable, Hashable, Sendable {
    var id: ID<TransactionData> = .init()
    var date: Date = .now
    var memo: String = ""
    var amount: Amount = .outflow(0.00)
    var isCleared: Bool = false
    var payee: Payee? = nil
    var category: TransactionCategory? = nil
    var account: TransactionAccount
    var linkedTransactionID: ID<TransactionData>? = nil // only when payee type is .transfer
}
