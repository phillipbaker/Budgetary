//
//  AvailablePresentation.swift
//  Budgetary
//
//  Created by Phillip Baker on 01/12/2025.
//

import SwiftUI

public protocol AvailablePresentation: Equatable, Sendable {
    var total: String { get }
    var cashFromLastMonth: String { get }
    var assignedThisMonth: String { get }
    var cashSpendingThisMonth: String { get }
    var message: String { get }
    var lightModeForegroundColor: Color { get }
    var lightModeBackgroundColor: Color { get }
    var darkModeForegroundColor: Color { get }
    var darkModeBackgroundColor: Color { get }
    var maxAvailableForReassignment: Double { get }
}
