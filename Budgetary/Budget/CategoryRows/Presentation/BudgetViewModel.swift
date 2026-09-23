//
//  BudgetViewModel.swift
//  Budgetary
//
//  Created by Phillip Baker on 12/08/2024.
//

import Factory
import SwiftUI

@MainActor
@Observable
public final class BudgetViewModel {
    @ObservationIgnored private let store: AppStore
    @ObservationIgnored private let stateMapper: BudgetStateMapper
    @ObservationIgnored private var observationTask: Task<Void, Never>?
    
    var viewState: BudgetViewState = .notLoaded
    
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
        case let .budgetSwipedLeftGesture(monthYear):
            store.dispatch(.monthYearUpdated(monthYear.advanced(by: -1)))
        case let .budgetSwipedRightGesture(monthYear):
            store.dispatch(.monthYearUpdated(monthYear.advanced(by: 1)))
        case let .monthPickerMonthSelected(monthYear):
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
                // TODO: See if I can get this try out of here by reshaoing the readytoasign or otherwise testing for the optionsl. I can do it her by saying if case let .loaded(budgetData) - and test for a blaue for appState/monthYer otherwise viewState = specific error. Still would have an if/else block here but would remove do/catch and remove try all the way down the call tree.....
                do {
                    self.viewState = try stateMapper.map(appState: state)
                } catch {
                    self.viewState = .error(.failedToMapViewState)
                }
            }
        }
    }
    
    deinit {
        observationTask?.cancel()
    }
}
