//
//  AccountsState.swift
//  Budgetary
//
//  Created by Phillip Baker on 19/01/2026.
//

enum AccountsState: Sendable {
    case notLoaded
    case loading
    case error(AccountsError)
    case loaded([AccountData])
}

extension AccountsState {
    var isIdle: Bool {
        switch self {
        case .notLoaded, .error:
            return true
        case .loading, .loaded:
            return false
        }
    }
    
    var pickerState: AccountPickerState {
        switch self {
        case .notLoaded:
            return .notLoaded
        case .loading:
            return .loading
        case .error:
            return .error
        case .loaded(let accounts):
            return .loaded(accounts)
        }
    }
    
    var description: String {
        switch self {
        case .notLoaded:
            "Not Loaded"
        case .loading:
            "Loading"
        case .error(_):
            "Error"
        case .loaded(_):
            "Loaded"
        }
    }
}
