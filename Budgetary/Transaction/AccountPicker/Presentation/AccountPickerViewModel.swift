//
//  AccountPickerViewModel.swift
//  Budgetary
//
//  Created by Phillip Baker on 27/03/2026.
//

import Factory
import SwiftUI

@MainActor
@Observable
final class AccountPickerViewModel {
    
    // MARK: - Stored State

    @ObservationIgnored private let store: AppStore
    @ObservationIgnored private let mapper: AccountsPresentationMapper
    @ObservationIgnored private var observationTask: Task<Void, Never>?
    @ObservationIgnored let onSelect: (TransactionAccountPresentation) -> Void

    var viewState: AccountPickerStatePresentation = .loading
    var selectedAccount: TransactionAccountPresentation?
    
    // MARK: - Derived State
    
    var accountRows: [AccountPickerRowPresentation] {
        guard case .loaded(let accountRows) = viewState else { return [] }
        return accountRows
    }
    
    // MARK: - Init

    init(
        store: AppStore = Container.shared.appStore(),
        mapper: AccountsPresentationMapper = Container.shared.accountsPresentationMapper(),
        onSelect: @escaping (TransactionAccountPresentation) -> Void,
    ) {
        self.store = store
        self.mapper = mapper
        self.onSelect = onSelect
        observeStore()
    }
    
    // MARK: - Intent
    
    func selectAccountButtonTapped(_ account: TransactionAccountPresentation) {
        selectedAccount = account
        onSelect(account)
    }
    
    // MARK: - Store Observation

    private func observeStore() {
        observationTask = Task {
            for await state in store.observe() {
                switch state.accountsState.pickerState {
                case .notLoaded:
                    viewState = .notLoaded
                case .loading:
                    viewState = .loading
                case .error:
                    viewState = .error
                case .loaded(let accounts):
                    viewState = .loaded(mapper.mapRows(accounts: accounts))
                }
            }
        }
    }
    
    deinit {
        observationTask?.cancel()
    }
}
