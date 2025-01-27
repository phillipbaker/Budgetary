//
//  BudgetViewModel.swift
//  Budgetary
//
//  Created by Phillip Baker on 12/08/2024.
//

import Dependencies
import SwiftUI
import SwiftUINavigation

@Observable
public final class BudgetViewModel {
    @ObservationIgnored private var stateMapper: BudgetStateMapper
    @ObservationIgnored private var getBudgetUseCase: GetBudget
    
    var state: BudgetState
    var destination: Destination?
    
    @CasePathable
    enum Destination: String, Identifiable {
        case monthPicker
        case assignMoney
        case editCategories
        case coverOverspending
        case coverCategoryOverspending
        case newFilter
        case manageFilters
        case categoryDetail
        
        var id: String { rawValue }
    }
    
    init(
        state: BudgetState = .loading,
        stateMapper: BudgetStateMapper,
        getBudgetUseCase: GetBudget,
        destination: Destination? = nil
    ) {
        self.state = state
        self.stateMapper = stateMapper
        self.getBudgetUseCase = getBudgetUseCase
        self.destination = destination
    }

    @MainActor
    func handle(intent: BudgetIntent) {
        Task {
            switch intent {
            case let .getBudget(monthYear, filterId):
                await getBudget(for: monthYear, filteredBy: filterId)
            case let .budgetSwipedLeftGesture(monthYear, filterId):
                await getBudget(for: monthYear.advanced(by: -1), filteredBy: filterId)
            case let .budgetSwipedRightGesture(monthYear, filterId):
                await getBudget(for: monthYear.advanced(by: 1), filteredBy: filterId)
            case let .monthPickerMonthSelected(monthYear, filterId):
                await getBudget(for: monthYear, filteredBy: filterId)
            case let .filterButtonTapped(monthYear, filterId):
                await getBudget(for: monthYear, filteredBy: filterId)
            case let .clearFilterButtonTapped(monthYear):
                await getBudget(for: monthYear, filteredBy: CategoryFilter.allCategories.id)
            }
        }
    }

    func handle(destination: Destination?) {
        switch destination {
        case .monthPicker:
            self.destination = .monthPicker
        case .editCategories:
            self.destination = .editCategories
        case .assignMoney:
            self.destination = .assignMoney
        case .coverOverspending:
            self.destination = .coverOverspending
        case .coverCategoryOverspending:
            self.destination = .coverCategoryOverspending
        case .newFilter:
            self.destination = .newFilter
        case .manageFilters:
            self.destination = .manageFilters
        case .categoryDetail:
            self.destination = .categoryDetail
        case .none:
            self.destination = nil
        }
    }

    private func getBudget(for monthYear: MonthYear, filteredBy filterId: String) async {
        for await budget in await getBudgetUseCase.budget(for: monthYear, filteredBy: filterId) {
            // not handling errors
            // need to make it throw and catch all the way through the app
            // or wrap budget in a result type with error adn handle that here
            // switch result
            // case rror self.state = .error(typeOfError)
            // case success self.state = self.stateMapper.map(budget: budget)
            self.state = self.stateMapper.map(budget: budget)
        }
    }
}

//actor IntentHandler {
//    func handle(intent: BudgetIntent, viewModel: BudgetViewModel) async {
//        switch intent {
//        case let .getBudget(monthYear, filterId):
//            await viewModel.getBudget(for: monthYear, filteredBy: filterId)
//        case let .budgetSwipedLeftGesture(monthYear, filterId):
//            await viewModel.handle(intent: .budgetSwipedLeftGesture(monthYear: monthYear, filterId: filterId))
//        case let .budgetSwipedRightGesture(monthYear, filterId):
//            await viewModel.handle(intent: .budgetSwipedRightGesture(monthYear: monthYear, filterId: filterId))
//        case let .filterButtonTapped(monthYear, filterId):
//            await viewModel.handle(intent: .filterButtonTapped(monthYear: monthYear, id: filterId))
//        case let .clearFilterButtonTapped(monthYear):
//            await viewModel.handle(intent: .clearFilterButtonTapped(monthYear: monthYear))
//        }
//    }
//}
