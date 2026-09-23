//
//  CreditCardAvailablePresentation.swift
//  Budgetary
//
//  Created by Phillip Baker on 01/12/2025.
//

import SwiftUI

public struct CreditCardAvailablePresentation: AvailablePresentation, Equatable, Sendable {
    public var total: String
    public let cashFromLastMonth: String
    public let assignedThisMonth: String
    public let cashSpendingThisMonth: String
//    let creditSpendingThisMonth: String
    public let message: String
    public let lightModeForegroundColor: Color
    public let lightModeBackgroundColor: Color
    public let darkModeForegroundColor: Color
    public let darkModeBackgroundColor: Color
    public let maxAvailableForReassignment: Double
}
