//
//  CategoryRowPresentation.swift
//  Budgetary
//
//  Created by Phillip Baker on 25/10/2024.
//

import Foundation

public struct CategoryRowPresentation<As: AssignedPresentation, Ac: ActivityPresentation, Av: AvailablePresentation>: BudgetRowPresentation, Equatable, Identifiable {
    
    public let id: BudgetRowID
    public let name: String
    public let notes: String
    public let isHidden: Bool
    public let assigned: [MonthYear: As]
    public let activity: [MonthYear: Ac]
    public let available: [MonthYear: Av]
}

public struct CategoryMonthRowPresentation<As: AssignedPresentation, Ac: ActivityPresentation, Av: AvailablePresentation>: BudgetMonthRowPresentation, Equatable, Identifiable, Sendable {
    
    public let id: BudgetRowID
    public let name: String
    public let notes: String
    public let isHidden: Bool
    public let assigned: As
    public let activity: Ac
    public let available: Av
}
