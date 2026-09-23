//
//  PayeePickerState.swift
//  Budgetary
//
//  Created by Phillip Baker on 09/05/2025.
//

public enum PayeePickerState: Equatable, Hashable, Sendable {
    case notLoaded
    case loading
    case error
    case loaded([Payee])
}
