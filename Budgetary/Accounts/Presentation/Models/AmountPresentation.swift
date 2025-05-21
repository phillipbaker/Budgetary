//
//  AmountPresentation.swift
//  Budgetary
//
//  Created by Phillip Baker on 02/05/2025.
//

import Foundation

public enum AmountPresentation: Equatable, Hashable, Sendable {
    case inflow(String)
    case outflow(String)
    
    var value: String {
        switch self {
        case let .inflow(amount):
            return amount
        case let .outflow(amount):
            return "-" + amount
        }
    }
}

//
//struct IdentifiedAmount: Identifiable, Hashable {
//    let id: String = UUID().uuidString
//    let presentation: AmountPresentation
//}
