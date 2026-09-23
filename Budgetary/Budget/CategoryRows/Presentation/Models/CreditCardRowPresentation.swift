//
//  CreditCardRowPresentation.swift
//  Budgetary
//
//  Created by Phillip Baker on 11/11/2025.
//

import Foundation

public struct CreditCardRowPresentation<As: AssignedPresentation, Ac: ActivityPresentation, Av: AvailablePresentation>: BudgetRowPresentation, Equatable, Identifiable, Sendable {
    
    public let id: BudgetRowID
    public let name: String
    public let isHidden: Bool
    public let assigned: [MonthYear: As]
    public let activity: [MonthYear: Ac]
    public let available: [MonthYear: Av]
}
