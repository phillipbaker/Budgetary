//
//  BudgetViewModel.swift
//  Budgetary
//
//  Created by Phillip Baker on 12/08/2024.
//

import SwiftUI
import SwiftUINavigation

@Observable
public final class BudgetViewModel {
    @ObservationIgnored private var stateMapper: BudgetStateMapper
    @ObservationIgnored private var getBudgetUseCase: GetBudget
    @ObservationIgnored private var assignMoneyUseCase: AssignMoney
    
    var state: BudgetState
    var destination: Destination?
    
    @CasePathable
    enum Destination: String {
        case monthPicker
        case assignMoney
        case editCategories
        case coverOverspending
        case coverCategoryOverspending
        case newFilter
        case manageFilters
        case categoryDetail
        case autoAssign
        case moveMoney
        
        var id: String { rawValue }
    }
    
    init(
        state: BudgetState = .loading,
        stateMapper: BudgetStateMapper,
        getBudgetUseCase: GetBudget,
        assignMoneyUseCase: AssignMoney,
        destination: Destination? = nil
    ) {
        self.state = state
        self.stateMapper = stateMapper
        self.getBudgetUseCase = getBudgetUseCase
        self.assignMoneyUseCase = assignMoneyUseCase
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
            case let .updateAssignedAmount(categoryId: categoryId, monthYear: monthYear, amount: amount):
                await assignMoneyUseCase.update(assignedValue: amount, to: categoryId, for: monthYear)
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
        case .autoAssign:
            self.destination = .autoAssign
        case .moveMoney:
            self.destination = .moveMoney
        case .none:
            self.destination = nil
        }
    }
    
    // need some task mangement here? Don’t want to add a new listener every time this is called...
    private func getBudget(for monthYear: MonthYear, filteredBy filterId: String) async {
        for await budget in getBudgetUseCase.budget(for: monthYear, filteredBy: filterId) {
            // not handling errors
            // need to make it throw and catch all the way through the app
            // or wrap budget in a result type with error adn handle that here
            // switch result
            // case error self.state = .error(typeOfError)
            // case success self.state = self.stateMapper.map(budget: budget)
            self.state = self.stateMapper.map(budget: budget)
        }
    }
}
