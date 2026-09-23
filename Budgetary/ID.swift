//
//  ID.swift
//  Budgetary
//
//  Created by Phillip Baker on 08/12/2025.
//

import Foundation

public struct ID<Value>: Hashable, Codable, Sendable {
    let rawValue: UUID

    public init() {
        self.rawValue = UUID()
    }
    
    public init(_ raw: UUID) {
        self.rawValue = raw
    }
    
    public init?(_ raw: UUID?) {
        guard let raw else { return nil }
        self.rawValue = raw
    }
}

public extension ID {
    init<Other>(_ other: ID<Other>) {
        self.rawValue = other.rawValue
    }

    init?<Other>(_ other: ID<Other>?) {
        guard let other else { return nil }
        self.init(other.rawValue)
    }
}
