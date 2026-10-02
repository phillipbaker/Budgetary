//
//  ReadyToAssignPresentation.swift
//  Budgetary
//
//  Created by Phillip Baker on 22/11/2024.
//

import SwiftUI

public struct ReadyToAssignPresentation: Equatable, Sendable {
    let readyToAssignFromLastMonth: String
    let cashOverspendingFromLastMonth: String
    let inflowThisMonth: String
    let assignedThisMonth: String
    let assignedInFuture: String
    let readyToAssignThisMonth: String
    let lightModeForegroundColor: Color
    let darkModeForegroundColor: Color
    let lightModeBackgroundColor: Color
    let darkModeBackgroundColor: Color
    let message: String
}
