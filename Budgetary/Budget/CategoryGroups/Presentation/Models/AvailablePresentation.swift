//
//  AvailablePresentation.swift
//  Budgetary
//
//  Created by Phillip Baker on 19/11/2024.
//

import SwiftUI

public struct AvailablePresentation: Equatable {
    var total: String
    let cashFromLastMonth: String
    let assignedThisMonth: String
    let cashSpendingThisMonth: String
//    let creditSpendingThisMonth: String
    let message: String
    let lightModeForegroundColor: Color
    let lightModeBackgroundColor: Color
    let darkModeForegroundColor: Color
    let darkModeBackgroundColor: Color
    let maxAvailableForReassignment: Double
}
