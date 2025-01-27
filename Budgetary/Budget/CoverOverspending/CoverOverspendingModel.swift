//
//  CoverOverspendingModel.swift
//  Budgetary
//
//  Created by Phillip Baker on 17/10/2024.
//

import SwiftUI
import SwiftUINavigation

//@Observable
//final class CoverOverspendingModel: Identifiable {
//    var id: String = UUID().uuidString
//    
//    var selectedMonthYear: MonthYear
//    var categoryToCover: CategoryPresentation?
//    var selectedCoverFromCategories: [CategoryPresentation]
//    var categoryGroups: [CategoryGroupPresentation]
//    
//    var totalToMove: String {
//        return selectedCoverFromCategories
//            .compactMap { Decimal($0.proposedReassignment) }
//            .reduce(0.00, +)
//            .formatted(.currency(code: "GBP"))
//    }
//    
//    var destination: Destination? {
//        didSet { self.bind() }
//    }
//    
//    @CasePathable
//    enum Destination {
//        case coverOverspendingFrom(CoverOverspendingFromModel)
//        case overspentCategoryPicker(OverspentCategoryPickerModel)
//    }
//    
//    init(
//        selectedMonthYear: MonthYear,
//        categoryToCover: CategoryPresentation? = nil,
//        selectedCoverFromCategories: [CategoryPresentation] = [],
//        categoryGroups: [CategoryGroupPresentation],
//        destination: Destination? = nil
//    ) {
//        self.selectedMonthYear = selectedMonthYear
//        self.categoryToCover = categoryToCover
//        self.selectedCoverFromCategories = selectedCoverFromCategories
//        self.categoryGroups = categoryGroups
//        self.destination = destination
//        self.bind()
//    }
//    
//    private func bind() {
//        switch destination {
//        case let .coverOverspendingFrom(coverOverspendingFromModel):
//            coverOverspendingFromModel.addCoverFromCategory = { [weak self] category in
//                guard let self else { return }
//                defer { self.destination = nil }
//                
//                self.selectedCoverFromCategories.append(category)
//                
//                // Set starting reassignment to the min of money needed and money available.
//                // If needed more than available to cover take all and there is a remaining balance to fill with other categories
//                // If availabled more then only assign what is needed to cover the overspend
//                let moneyAvailable = category.available[selectedMonthYear] ?? 0.00
//                // TODO: Need to make Ready to Assign Category real thing to make this part work...
//                let amountToCover = self.categoryToCover?.available[selectedMonthYear] ?? 100.00
//                self.selectedCoverFromCategories[id: category.id]?.proposedReassignment = Double(min(moneyAvailable, amountToCover))
//                
//                for group in self.categoryGroups {
//                    self.categoryGroups[id: group.id]?.categories.remove(id: category.id)
//                }
//            }
//        case .overspentCategoryPicker, .none:
//            break
//        }
//    }
//    
//    func selectCategoryButtonTapped() {
//        self.destination = .coverOverspendingFrom(
//            CoverOverspendingFromModel(
//                selectedMonthYear: selectedMonthYear,
//                moneyAvailableCategoryGroups: categoryGroups.filtered(by: .moneyAvailable, for: selectedMonthYear)
//            )
//        )
//    }
//}
