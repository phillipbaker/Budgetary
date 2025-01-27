//
//  ReadyToAssign.swift
//  Budgetary
//
//  Created by Phillip Baker on 21/11/2024.
//

import Foundation

public struct ReadyToAssign: Equatable, Sendable {
    let availableToAssignFromLastMonth: Decimal
    let inflowThisMonth: Decimal
    let totalInflowsThisMonth: Decimal
    let cashOverspendingLastMonth: Decimal
    // TODO: Add credit overspending logic when adding debt group
    let assignedThisMonth: Decimal
    let assignedInFuture: Decimal
    let totalOutflowsThisMonth: Decimal
    let readyToAssignThisMonth: Decimal
}
