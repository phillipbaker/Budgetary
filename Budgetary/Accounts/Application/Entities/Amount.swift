//
//  Amount.swift
//  Budgetary
//
//  Created by Phillip Baker on 22/05/2025.
//

import Foundation

public enum Amount: Codable, Equatable, Hashable, Sendable {
    case inflow(Decimal)
    case outflow(Decimal)
    
    var value: Decimal {
        switch self {
        case let .inflow(amount):
            return amount
        case let .outflow(amount):
            return amount
        }
    }
}
