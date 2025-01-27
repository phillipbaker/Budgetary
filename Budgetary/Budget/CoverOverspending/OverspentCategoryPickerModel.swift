//
//  OverspentCategoryPickerModel.swift
//  Budgetary
//
//  Created by Phillip Baker on 21/10/2024.
//

import SwiftUI

@Observable
final class OverspentCategoryPickerModel: Identifiable {
    var id: String
    var selectedMonthYear: MonthYear
    var overspentCategoryGroups: [CategoryGroupPresentation]
    
    init(
        id: String = UUID().uuidString,
        selectedMonthYear: MonthYear,
        overspentCategoryGroups: [CategoryGroupPresentation]
    ) {
        self.id = id
        self.selectedMonthYear = selectedMonthYear
        self.overspentCategoryGroups = overspentCategoryGroups
    }
    
    func selectCategoryButtonTapped() {
        
    }
}
