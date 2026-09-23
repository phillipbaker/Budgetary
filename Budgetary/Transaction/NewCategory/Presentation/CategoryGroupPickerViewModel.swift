//
//  CategoryGroupPickerViewModel.swift
//  Budgetary
//
//  Created by Phillip Baker on 18/03/2026.
//

import Factory
import SwiftUI

@MainActor
@Observable
final class CategoryGroupPickerViewModel {
    
    // MARK: - Stored State
    
    @ObservationIgnored private let store: AppStore
    @ObservationIgnored private var observationTask: Task<Void, Never>?
    @ObservationIgnored let onSelect: (CategoryGroupNamePresentation) -> Void
    
    var viewState: CategoryGroupPickerStatePresentation = .notLoaded

    var selectedGroup: CategoryGroupNamePresentation?
    var newCategoryGroupSheetIsPresented: Bool = false
    
    // MARK: - Derived State
    
    var categoryGroups: [CategoryGroupNamePresentation] {
        guard case .loaded(let categoryGroups) = viewState else { return [] }
        return categoryGroups
    }

    // MARK: - Init
    
    init(
        store: AppStore = Container.shared.appStore(),
        observationTask: Task<Void, Never>? = nil,
        selectedGroup: CategoryGroupNamePresentation? = nil,
        onSelect: @escaping ((CategoryGroupNamePresentation) -> Void)
    ) {
        self.store = store
        self.observationTask = observationTask
        self.selectedGroup = selectedGroup
        self.onSelect = onSelect
        observeStore()
    }
    
    // MARK: - Intent
    
    func selectGroupButtonTapped(_ group: CategoryGroupNamePresentation) {
        selectedGroup = group
        onSelect(group)
    }
    
    func newGroupButtonTapped() {
        newCategoryGroupSheetIsPresented = true
    }
    
    func onGroupCreated(_ group: CategoryGroupNamePresentation) {
        newCategoryGroupSheetIsPresented = false
        selectedGroup = group
        onSelect(group)
    }
    
    func onCancel() {
        newCategoryGroupSheetIsPresented = false
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
                case .loaded(let groups):
                    viewState = .loaded(map(categoryGroups: groups))
                }
            }
        }
    }
    
    deinit {
        observationTask?.cancel()
    }
    
    private func map(categoryGroups: [CategoryGroupRow]) -> [CategoryGroupNamePresentation] {
        return categoryGroups.map { group in
            map(categoryGroup: group)
        }
    }
    
    private func map(categoryGroup: CategoryGroupRow) -> CategoryGroupNamePresentation {
        return CategoryGroupNamePresentation(
            id: ID<CategoryGroupNamePresentation>(categoryGroup.id),
            name: categoryGroup.name
        )
    }
}
