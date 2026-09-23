//
//  HomeViewModel.swift
//  Budgetary
//
//  Created by Phillip Baker on 19/01/2026.
//

import Factory
import SwiftUI

@MainActor
@Observable
final class HomeViewModel {
    @ObservationIgnored private let store: AppStore
    @ObservationIgnored private var observationTask: Task<Void, Never>?
    
    var viewState: HomeState = .init(selectedTab: .budget, sheet: nil, tabDestinations: [.budget: [], .accounts: []])
    
    init(
        store: AppStore = Container.shared.appStore(),
        observationTask: Task<Void, Never>? = nil,
    ) {
        self.store = store
        self.observationTask = observationTask
        observeStore()
    }
    
    func handle(action: HomeAction) {
        switch action {
        case .tabSelected(let tab):
            store.dispatch(.tabSelected(tab))
        case .newTransactionButtonTapped(let tab):
            store.dispatch(.transactionSheetRequested(tab, nil))
        case .sheetDismissed:
            store.dispatch(.sheetDismissed)
        case .push(let tab, let destination):
            store.dispatch(.push(tab, destination))
        case .pop(let tab):
            store.dispatch(.pop(tab))
        case .popToRoot(let tab):
            store.dispatch(.popToRoot(tab))
        }
    }
    
    private func observeStore() {
        observationTask = Task {
            for await state in store.observe() {
                self.viewState = HomeState(
                    selectedTab: state.homeState.selectedTab,
                    sheet: state.sheet,
                    tabDestinations: state.tabDestinations
                )
            }
        }
    }
    
    deinit {
        observationTask?.cancel()
    }
}
