//
//  CreditCardAssignedPresentation.swift
//  Budgetary
//
//  Created by Phillip Baker on 11/11/2025.
//

public struct CreditCardAssignedPresentation: Equatable, Sendable {
    public let assignedThisMonth: String
    public let assignedLastMonth: String
    public let averageAssigned: String
    public let paidLastMonth: String
    public let averagePaid: String
}

extension CreditCardAssignedPresentation: AssignedPresentation {
    public var valueLastMonth: String { paidLastMonth }
    public var averageValue: String { averagePaid }
}
