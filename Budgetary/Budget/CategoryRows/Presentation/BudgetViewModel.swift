//
//  BudgetViewModel.swift
//  Budgetary
//
//  Created by Phillip Baker on 12/08/2024.
//

import Factory
import SwiftUI
import SwiftUINavigation

@MainActor
@Observable
public final class BudgetViewModel {
    @ObservationIgnored private let store: AppStore
    @ObservationIgnored private let stateMapper: BudgetStateMapper
    @ObservationIgnored private var observationTask: Task<Void, Never>?
    
    var viewState: BudgetViewState = .notLoaded
    
    var destination: Destination?
    
    @CasePathable
    enum Destination {
        case monthPicker
    }
    
    init(
        store: AppStore = Container.shared.appStore(),
        stateMapper: BudgetStateMapper = Container.shared.budgetStateMapper(),
        observationTask: Task<Void, Never>? = nil,
    ) {
        self.store = store
        self.stateMapper = stateMapper
        self.observationTask = observationTask
        observeStore()
    }
    
    func handle(action: BudgetAction) {
        switch action {
        case .budgetTabAppeared:
            store.dispatch(.loadBudgetRequested)
        case .monthPickerButtonTapped:
            destination = .monthPicker
        case let .budgetSwipedLeftGesture(monthYear):
            store.dispatch(.monthYearUpdated(monthYear.advanced(by: -1)))
        case let .budgetSwipedRightGesture(monthYear):
            store.dispatch(.monthYearUpdated(monthYear.advanced(by: 1)))
        case let .monthPickerMonthSelected(monthYear):
            destination = nil
            store.dispatch(.monthYearUpdated(monthYear))
        case let .filterButtonTapped(filterID):
            store.dispatch(.budgetRowsFiltered(filterID))
        case let .clearFilterButtonTapped(filterID):
            store.dispatch(.budgetRowsFiltered(filterID))
        case let .updateAssignedAmount(assignedAmount, categoryID, monthYear):
            store.dispatch(.assignMoneyRequested(assignedAmount, categoryID, monthYear))
        }
    }
    
    private func observeStore() {
        observationTask = Task {
            for await state in store.observe() {
                self.viewState = stateMapper.map(appState: state)
            }
        }
    }
    
    deinit {
        observationTask?.cancel()
    }
}
