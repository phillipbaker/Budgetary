//
//  Amount.swift
//  Budgetary
//
//  Created by Phillip Baker on 22/05/2025.
//

import Foundation

/// Associated values are always non-negative; the case carries the direction.
public enum Amount: Codable, Equatable, Hashable, Sendable {
    case inflow(Decimal)
    case outflow(Decimal)
    
    var magnitude: Decimal {
        switch self {
        case let .inflow(amount), let .outflow(amount):
            return abs(amount)
        }
    }
    
    var signedValue: Decimal {
        switch self {
        case let .inflow(amount):
            assert(amount >= 0, "Amount values must be non-negative, got \(amount)")
            return abs(amount)
        case let .outflow(amount):
            assert(amount >= 0, "Amount values must be non-negative, got \(amount)")
            return -abs(amount)
        }
    }
}
