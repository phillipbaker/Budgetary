//
//  CategoryPresentation.swift
//  Budgetary
//
//  Created by Phillip Baker on 25/10/2024.
//

import Foundation

public struct CategoryPresentation: Equatable, Identifiable {
    public let id: String
    let name: String
    let notes: String
    let isHidden: Bool
    let assigned: [MonthYear: AssignedPresentation]
    let activity: [MonthYear: ActivityPresentation]
    let available: [MonthYear: AvailablePresentation]
//    let monthTotals: [MonthYear: CategoryMonthTotals]
}
//
//public struct CategoryMonthTotals: Equatable {
//    let assigned: String
//    let activity: String
//    let available: String
//}
