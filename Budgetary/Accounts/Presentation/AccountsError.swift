//
//  AccountsError.swift
//  Budgetary
//
//  Created by Phillip Baker on 19/01/2026.
//

public enum AccountsViewStateError: Error {
    case unknownAccountType
    case invalidStartingBalance
    case unknownError
}

public enum AccountsError: Error {
    case unknownError
    case accountsLoadFailed
}
