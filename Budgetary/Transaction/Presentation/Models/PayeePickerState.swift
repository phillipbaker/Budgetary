//
//  PayeePickerState.swift
//  Budgetary
//
//  Created by Phillip Baker on 09/05/2025.
//

public enum PayeePickerState: Sendable {
    case loading
    case error
    case success([PayeeName])
}
