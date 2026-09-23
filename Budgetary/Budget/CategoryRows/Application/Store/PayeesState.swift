//
//  PayeesState.swift
//  Budgetary
//
//  Created by Phillip Baker on 27/03/2026.
//

enum PayeesState: Sendable {
    case notLoaded
    case loading
    case error(PayeesError)
    case loaded([Payee])
}

extension PayeesState {
    var isIdle: Bool {
        switch self {
        case .notLoaded, .error:
            return true
        case .loading, .loaded:
            return false
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

public enum PayeesError: Error {
    case dataError
    case payeesLoadFailed
}
