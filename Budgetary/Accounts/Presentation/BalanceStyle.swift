//
//  BalanceStyle.swift
//  Budgetary
//
//  Created by Phillip Baker on 12/11/2026.
//

import SwiftUI

public enum BalanceStyle: Equatable, Hashable, Sendable {
    case negative, zero, positive
    
    var color: Color {
        switch self {
        case .positive: .green
        case .zero: .primary
        case .negative: .primary
        }
    }
}
