//
//  CreditCardPaymentGroupPresentation.swift
//  Budgetary
//
//  Created by Phillip Baker on 03/12/2025.
//

public struct CreditCardPaymentGroupPresentation: BudgetGroupPresentation, Equatable, Identifiable {    
    public typealias CategoryRow = CreditCardRowPresentation
    
    public let id: ID<CreditCardPaymentGroupPresentation>
    public let name: String
    public var isHidden: Bool
    public let assignedTotal: [MonthYear: String]
    public let activityTotal: [MonthYear: String]
    public let availableTotal: [MonthYear: String]
    public let categories: [CategoryRow<CreditCardAssignedPresentation, CreditCardActivityPresentation, CreditCardAvailablePresentation>]
}
