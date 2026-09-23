//
//  CalculatorState.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/03/2026.
//

import Foundation

enum CalculatorState: Equatable {
    case idle(lhs: Decimal)
    case pendingOperation(lhs: Decimal, operation: AmountOperation, rhs: Decimal)

    var primary: Decimal {
        switch self {
        case .idle(let lhs):
            return lhs
        case .pendingOperation(let lhs, _, _):
            return lhs
        }
    }

    var secondary: Decimal? {
        guard case .pendingOperation(_, _, let rhs) = self else { return nil }
        return rhs
    }

    var operation: AmountOperation? {
        guard case .pendingOperation(_, let op, _) = self else { return nil }
        return op
    }

    func settingPrimary(_ value: Decimal) -> CalculatorState {
        let magnitude = abs(value)
        switch self {
        case .idle:
            return .idle(lhs: magnitude)
        case .pendingOperation(_, let op, let rhs):
            return .pendingOperation(lhs: magnitude, operation: op, rhs: rhs)
        }
    }

    func applyingOperation(_ operation: AmountOperation) -> CalculatorState {
        guard case .idle(let lhs) = self else { return self }
        return .pendingOperation(lhs: abs(lhs), operation: operation, rhs: 0)
    }

    func settingSecondary(_ value: Decimal) -> CalculatorState {
        guard case .pendingOperation(let lhs, let op, _) = self else { return self }
        return .pendingOperation(lhs: lhs, operation: op, rhs: abs(value))
    }

    func cancelledOperation() -> CalculatorState {
        guard case .pendingOperation(let lhs, _, _) = self else { return self }
        return .idle(lhs: abs(lhs))
    }
}
