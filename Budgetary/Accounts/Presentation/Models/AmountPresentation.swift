//
//  AmountPresentation.swift
//  Budgetary
//
//  Created by Phillip Baker on 02/05/2025.
//

import Foundation

public struct AmountPresentation: Equatable, Hashable, Sendable {
    let type: TransactionTypePresentation
    let value: String
}
public struct AmountDraft: Equatable, Hashable, Sendable {
    var type: TransactionTypePresentation
    var value: String
}

public enum TransactionType: String, CaseIterable, Equatable, Hashable, Identifiable, Sendable {
    case outflow, inflow
    public var id: String { rawValue }
}

import SwiftUI

public enum TransactionTypePresentation: String, CaseIterable, Equatable, Hashable, Identifiable, Sendable {
    case outflow, inflow
    public var id: String { rawValue }
    
    var color: Color {
        self == .outflow ? .red : .green
    }
    
    var uiColor: UIColor {
        UIColor(color)
    }
}

