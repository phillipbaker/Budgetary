//
//  CoverOverspendingFromModel.swift
//  Budgetary
//
//  Created by Phillip Baker on 21/10/2024.
//

import SwiftUI
import XCTestDynamicOverlay

@Observable
final class CoverOverspendingFromModel: Identifiable {
    var id: String
    var selectedMonthYear: MonthYear
    var moneyAvailableCategoryGroups: [CategoryGroupPresentation]
    var filteredMoneyAvailableCategoryGroups: [CategoryGroupPresentation]
    
    var addCoverFromCategory: (CategoryPresentation) -> Void = unimplemented("CoverOverspendingFromModel.addCoverFromCategory")
    
    var searchText: String = "" {
        didSet {
            if searchText.isEmpty {
                self.filteredMoneyAvailableCategoryGroups = moneyAvailableCategoryGroups
            } else {
                self.filteredMoneyAvailableCategoryGroups = moneyAvailableCategoryGroups  // .filtered(by: searchText)
            }
        }
    }
    
    init(
        id: String = UUID().uuidString,
        selectedMonthYear: MonthYear,
        moneyAvailableCategoryGroups: [CategoryGroupPresentation]
    ) {
        self.id = id
        self.selectedMonthYear = selectedMonthYear
        self.moneyAvailableCategoryGroups = moneyAvailableCategoryGroups
        self.filteredMoneyAvailableCategoryGroups = moneyAvailableCategoryGroups
    }
    
    func selectCategoryButtonTapped(for category: CategoryPresentation) {
        addCoverFromCategory(category)
    }
}
