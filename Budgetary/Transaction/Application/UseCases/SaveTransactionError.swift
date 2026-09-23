//
//  SaveTransactionError.swift
//  Budgetary
//
//  Created by Phillip Baker on 18/09/2026.
//

enum SaveTransactionError: Error {
    case amountError
    case payeeError
    case selfTransferError
    case categoryError
    case accountError
}
