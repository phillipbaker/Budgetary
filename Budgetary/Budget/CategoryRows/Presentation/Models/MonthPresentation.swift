//
//  MonthPresentation.swift
//  Budgetary
//
//  Created by Phillip Baker on 29/11/2024.
//

import SwiftUI

public struct MonthPresentation: Equatable, Hashable, Identifiable, Sendable {
    public let id: ID<MonthPresentation>
    let monthYear: MonthYear
    let isDisabled: Bool
    let isCurrentMonth: Bool
    let foregroundColor: Color
    let backgroundColor: Color
}
