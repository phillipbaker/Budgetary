//
//  CategoryGroupPresentation.swift
//  Budgetary
//
//  Created by Phillip Baker on 25/10/2024.
//

import Foundation

public struct CategoryGroupPresentation: Equatable, Identifiable {
    public let id: String
    let name: String
    let isHidden: Bool
    let assignedTotal: [MonthYear: String]
    let activityTotal: [MonthYear: String]
    let availableTotal: [MonthYear: String]
    let categories: [CategoryPresentation]
//    let categoryGroupMonths: [MonthYear: CategoryGroupMonthTotals]
}

//public struct CategoryGroupMonthTotals: Equatable {
//    let assignedTotal: String
//    let activityTotal: String
//    let availableTotal: String
//}
