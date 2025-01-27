//
//  FilterCategoriesViewModel.swift
//  Budgetary
//
//  Created by Phillip Baker on 03/10/2024.
//

//import Dependencies
//import SwiftUI
//import SwiftUINavigation
//
//@Observable
//public final class FilterCategoriesViewModel {
//    @ObservationIgnored private var monthYear: MonthYear
////    @ObservationIgnored private var getBudgetUseCase: GetBudget
//
//    var filter: CategoryFilter
//    var destination: Destination?
//
//    @CasePathable
//    enum Destination {
//        case newFilter
//        case manageFilters
//    }
//    
//    init(
//        monthYear: MonthYear = .currentMonthYear,
////        getBudgetUseCase: GetBudget,
//        filter: CategoryFilter = .allCategories,
//        destination: Destination? = nil
//    ) {
//        self.monthYear = monthYear
//        self.filter = filter
//        self.destination = destination
//    }
//    
//    private func handle(filterIntent: CategoryFilter) async {
//        switch filterIntent {
//        case .allCategories:
//            break
////            let _ = await getBudgetUseCase.budget(for: monthYear, filteredBy: .allCategories)
//        case .underfunded:
//            break
////            let _ = await getBudgetUseCase.budget(for: monthYear, filteredBy: .underfunded)
//        case .moneyAvailable:
//            break
////            let _ = await getBudgetUseCase.budget(for: monthYear, filteredBy: .moneyAvailable)
//        }
//    }
//    
//    func handle(destination: Destination?) {
//        switch destination {
//        case .newFilter:
//            self.destination = .newFilter
//        case .manageFilters:
//            self.destination = .manageFilters
//        case .none:
//            self.destination = nil
//        }
//    }
//}
