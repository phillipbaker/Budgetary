//
//  AccountPickerState.swift
//  Budgetary
//
//  Created by Phillip Baker on 27/03/2026.
//

public enum AccountPickerState: Equatable, Hashable, Sendable {
    case notLoaded
    case loading
    case error
    case loaded([AccountData])
}
