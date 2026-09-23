//
//  AssignedPresentation.swift
//  Budgetary
//
//  Created by Phillip Baker on 01/12/2025.
//

public protocol AssignedPresentation: Equatable, Sendable {
    var assignedThisMonth: String { get }
    var assignedLastMonth: String { get }
    var averageAssigned: String { get }
    var valueLastMonth: String { get }
    var averageValue: String { get }
}
