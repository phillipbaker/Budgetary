//
//  AccountsViewModel.swift
//  Budgetary
//
//  Created by Phillip Baker on 03/05/2025.
//

import Factory
import SwiftUI

@MainActor
@Observable
public final class AccountsViewModel {
    @ObservationIgnored private let store: AppStore
    @ObservationIgnored private let stateMapper: AccountsStateMapper
    @ObservationIgnored private var observationTask: Task<Void, Never>?
    
    var viewState: AccountsViewState = .notLoaded
    
    init(
        store: AppStore = Container.shared.appStore(),
        stateMapper: AccountsStateMapper = Container.shared.accountsStateMapper(),
        observationTask: Task<Void, Never>? = nil,
    ) {
        self.store = store
        self.stateMapper = stateMapper
        self.observationTask = observationTask
        observeStore()
    }

    func handle(action: AccountsAction) {
        switch action {
        case .accountsTabAppeared:
            store.dispatch(.loadBudgetAccountsRequested)
        case .addAccountButtonTapped:
            store.dispatch(.addAccountSheetRequested)
        }
    }
    
    private func observeStore() {
        observationTask = Task {
            for await state in store.observe() {
                self.viewState = stateMapper.map(appState: state)
            }
        }
    }
}
