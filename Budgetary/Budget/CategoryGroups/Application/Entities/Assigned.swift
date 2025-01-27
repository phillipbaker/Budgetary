//
//  AutoAssign.swift
//  Budgetary
//
//  Created by Phillip Baker on 19/11/2024.
//

import Foundation

public struct Assigned: Equatable, Hashable, Sendable {
//    let underfunded: Decimal
    let assignedThisMonth: Decimal
    let assignedLastMonth: Decimal
    let spentLastMonth: Decimal
    let averageAssigned: Decimal
    let averageSpent: Decimal
}
