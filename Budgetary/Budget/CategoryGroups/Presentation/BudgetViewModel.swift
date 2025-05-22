//
//  BudgetViewModel.swift
//  Budgetary
//
//  Created by Phillip Baker on 12/08/2024.
//

import Factory
import SwiftUI

@Observable
public final class BudgetViewModel {
    @ObservationIgnored private let stateMapper: BudgetStateMapper = Container.shared.budgetStateMapper()
    @ObservationIgnored private let getBudgetUseCase: GetBudgetUseCase = Container.shared.getBudgetUseCase()
    @ObservationIgnored private let assignMoneyUseCase: AssignMoney = Container.shared.assignMoneyUseCase()
    
    var state: BudgetState
    
    init(state: BudgetState = .loading) {
        self.state = state
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
