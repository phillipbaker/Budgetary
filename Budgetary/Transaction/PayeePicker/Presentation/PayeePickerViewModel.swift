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
    var newPayeeSheetIsPresented: Bool = false
    
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
        guard !searchText.isEmpty else { return [] }
        return payeeNames
            .flatMap(\.payees)
            .filter { $0.name.normalizedForComparison().contains(searchText.normalizedForComparison()) }
            .sorted { $0.name.rankedAgainst(text: searchText) < $1.name.rankedAgainst(text: searchText) }
    }
    
    var isNameClash: Bool {
        payeeNames
            .flatMap(\.payees)
            .map { $0.name.normalizedForComparison() }
            .contains(searchText.normalizedForComparison())
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
    
    func newPayeeButtonTapped() {
        newPayeeSheetIsPresented = true
    }
    
    func selectPayeeButtonTapped(_ payee: PayeePresentation) {
        onSelect(payee)
    }
    
    func cancelNewPayeeButtonTapped() {
        newPayeeSheetIsPresented = false
    }
    
    func onPayeeCreated(_ payee: PayeePresentation) {
        newPayeeSheetIsPresented = false
        onSelect(payee)
    }
    
    func onDismissPicker() {

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
                    viewState = .loaded(mapper.map(payees: payees))
                }
            }
        }
    }
    
    deinit {
        observationTask?.cancel()
    }
}


