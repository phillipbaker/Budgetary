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
    
    var accounts: [TransactionAccountPresentation] {
        guard case .loaded(let accounts) = viewState else { return [] }
        return accounts
    }
    
    func foregroundStyle(for account: TransactionAccountPresentation) -> Color {
        return .primary
        // TODO: Add balacne to TransactionAccountPresentation and use that to format the balacen in currnecy code. OR even better put this color in the presentation model and shift logic to the mapper
        // tint and/or foregroundColor...
        // gray for zero balance
        // black with minus sign for negative balance
        // green for positive balance...
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
                    viewState = .loaded(mapper.map(accounts: accounts))
                }
            }
        }
    }
    
    deinit {
        observationTask?.cancel()
    }
}
