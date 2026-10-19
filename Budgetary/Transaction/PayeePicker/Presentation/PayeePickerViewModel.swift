//
//  PayeePickerViewModel.swift
//  Budgetary
//
//  Created by Phillip Baker on 27/03/2026.
//

import Factory
import SwiftUI

@MainActor
@Observable
final class PayeePickerViewModel {
    
    // MARK: - Stored State
    
    @ObservationIgnored private let store: AppStore
    @ObservationIgnored private let mapper: PayeePresentationMapper
    @ObservationIgnored private var observationTask: Task<Void, Never>?
    @ObservationIgnored let onSelect: (PayeePresentation) -> Void
    
    var viewState: PayeesStatePresentation = .loading
    var searchText: String = ""
    
    // Set when a save is dispatched; cleared once the matching payee appears in the store.
    private var pendingSaveName: String?
    
    // MARK: - Derived State
    
    var payeeNames: [PayeeName] {
        guard case .loaded(let payeePickerData) = viewState else { return [] }
        return payeePickerData.alphabeticalPayees
    }
    
    var transferPayees: [PayeePresentation] {
        guard case .loaded(let payeePickerData) = viewState else { return [] }
        return payeePickerData.transferPayees
    }
    
    var filteredPayees: [PayeePresentation] {
        guard isSearching else { return [] }
        let trimmed = trimmedSearchText
        let candidate = trimmed.normalizedForComparison()
        return allPayees
            .filter { $0.name.normalizedForComparison().contains(candidate) }
            .sorted { $0.name.rankedAgainst(text: trimmed) < $1.name.rankedAgainst(text: trimmed) }
    }
    
    var isSearching: Bool {
        !trimmedSearchText.isEmpty
    }
    
    var isNameClash: Bool {
        let candidate = trimmedSearchText.normalizedForComparison()
        return allPayees
            .contains { $0.name.normalizedForComparison() == candidate }
    }
    
    var canCreatePayee: Bool {
        isSearching && !isNameClash && pendingSaveName == nil
    }
    
    var trimmedSearchText: String {
        searchText.trimmingCharacters(in: .whitespaces)
    }
    
    private var allPayees: [PayeePresentation] {
        transferPayees + payeeNames.flatMap(\.payees)
    }
    
    // MARK: - Init
    
    init(
        store: AppStore = Container.shared.appStore(),
        mapper: PayeePresentationMapper = Container.shared.payeePresentationMapper(),
        onSelect: @escaping (PayeePresentation) -> Void
    ) {
        self.store = store
        self.mapper = mapper
        self.onSelect = onSelect
        observeStore()
    }
    
    // MARK: - Intent
    
    func selectPayeeButtonTapped(_ payee: PayeePresentation) {
        onSelect(payee)
    }
    
    func newPayeeFromSearchText() {
        guard canCreatePayee else { return }
        pendingSaveName = trimmedSearchText
        store.dispatch(.createPayeeRequested(trimmedSearchText))
    }
    
    // MARK: - Store Observation
    
    private func observeStore() {
        observationTask = Task {
            for await state in store.observe() {
                switch state.payeesState {
                case .notLoaded:
                    viewState = .notLoaded
                case .loading:
                    viewState = .loading
                case .error:
                    viewState = .error
                case .loaded(let payees):
                    let payeePickerData: PayeePickerDataPresentation = mapper.map(payees: payees)
                    viewState = .loaded(payeePickerData)

                    // If a save is in flight, check whether the new payee has landed.
                    if let pendingName = self.pendingSaveName {
                        let created = payeePickerData.alphabeticalPayees
                            .flatMap(\.payees)
                            .first { $0.name.normalizedForComparison() == pendingName.normalizedForComparison() }
                        if let created {
                            withAnimation {
                                self.pendingSaveName = nil
                                self.onSelect(created)
                            }
                        }
                    }
                }
            }
        }
    }
    
    deinit {
        observationTask?.cancel()
    }
}


