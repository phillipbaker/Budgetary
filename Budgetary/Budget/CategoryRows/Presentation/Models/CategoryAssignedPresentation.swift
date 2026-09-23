//
//  CategoryAssignedPresentation.swift
//  Budgetary
//
//  Created by Phillip Baker on 19/11/2024.
//

public struct CategoryAssignedPresentation: Equatable, Sendable {
    public let assignedThisMonth: String
    public let assignedLastMonth: String
    public let averageAssigned: String
    public let spentLastMonth: String
    public let averageSpent: String
}

extension CategoryAssignedPresentation: AssignedPresentation {
    public var valueLastMonth: String { spentLastMonth }
    public var averageValue: String { averageSpent }
}
