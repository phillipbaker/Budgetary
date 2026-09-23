//
//  BudgetPresentation.swift
//  Budgetary
//
//  Created by Phillip Baker on 25/10/2024.
//

import Foundation

//public struct BudgetPresentation: Equatable, Identifiable, Sendable {
//    public var id: ID<BudgetPresentation>
//    let months: [MonthPresentation]
//    let readyToAssign: [MonthYear: ReadyToAssignPresentation]
//    let categoryGroups: [CategoryGroupPresentation]
//    let creditCardPaymentGroup: CreditCardPaymentGroupPresentation
//    let start: MonthYear
//    let end: MonthYear
//}

public struct BudgetPresentation: Equatable, Identifiable, Sendable {
    public let id: ID<BudgetPresentation>
    let monthYear: MonthYear
    let months: [MonthPresentation]
    let readyToAssign: ReadyToAssignPresentation
    let categoryGroups: [CategoryGroupPresentation]
    let creditCardPaymentGroup: CreditCardPaymentGroupPresentation
}


