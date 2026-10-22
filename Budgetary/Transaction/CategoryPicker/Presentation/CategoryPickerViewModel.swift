//
//  CategoryPickerViewModel.swift
//  Budgetary
//
//  Created by Phillip Baker on 18/03/2026.
//

import Factory
import SwiftUI

@MainActor
@Observable
final class CategoryPickerViewModel {
    
    // MARK: - Stored State

    @ObservationIgnored private let store: AppStore
    @ObservationIgnored private let mapper: CategoriesPresentationMapper
    @ObservationIgnored private var observationTask: Task<Void, Never>?
    @ObservationIgnored let onSelect: (TransactionCategoryPresentation) -> Void

    var viewState: CategoryGroupRowsStatePresentation = .notLoaded
    var searchText: String = ""
    var newCategorySheetIsPresented: Bool = false

    // MARK: - Derived State

    var categoryNames: [CategoryNamePresentation] {
        guard case .loaded(let names) = viewState else { return [] }
        return names
    }

    var filteredCategories: [TransactionCategoryPresentation] {
        guard isSearching else { return [] }
        let candidate = trimmedSearchText.normalizedForComparison()
        return categoryNames
            .flatMap(\.categories)
            .filter { $0.name.normalizedForComparison().contains(candidate) }
            .sorted { $0.name.rankedAgainst(text: trimmedSearchText) < $1.name.rankedAgainst(text: trimmedSearchText) }
    }

    var isNameClash: Bool {
        let candidate = trimmedSearchText.normalizedForComparison()
        return categoryNames
            .flatMap(\.categories)
            .map { $0.name.normalizedForComparison() }
            .contains(candidate)
    }
    
    var trimmedSearchText: String {
        searchText.trimmingCharacters(in: .whitespaces)
    }
    
    var isSearching: Bool {
        !trimmedSearchText.isEmpty
    }
    
    // MARK: - Init

    init(
        store: AppStore = Container.shared.appStore(),
        mapper: CategoriesPresentationMapper = Container.shared.categoriesPresentationMapper(),
        onSelect: @escaping (TransactionCategoryPresentation) -> Void,
    ) {
        self.store = store
        self.mapper = mapper
        self.onSelect = onSelect
        observeStore()
    }
    
    // MARK: - Intent

    func selectCategoryButtonTapped(_ category: TransactionCategoryPresentation) {
        onSelect(category)
    }
    
    func newCategoryButtonTapped() {
        newCategorySheetIsPresented = true
    }
    
    func cancelNewCategoryButtonTapped() {
        newCategorySheetIsPresented = false
    }
    
    func onCategoryCreated(_ category: TransactionCategoryPresentation) {
        onSelect(category)
        newCategorySheetIsPresented = false
    }
    
    // MARK: - Store Observation

    private func observeStore() {
        observationTask = Task {
            for await state in store.observe() {
                switch state.budgetState.categoryGroupRowsState {
                case .notLoaded:
                    viewState = .notLoaded
                case .loading:
                    viewState = .loading
                case .error:
                    viewState = .error
                case .loaded(let groupRows):
                    viewState = .loaded(mapper.map(categoryGroupRows: groupRows))
                }
            }
        }
    }
    
    deinit {
        observationTask?.cancel()
    }
}
