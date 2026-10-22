//
//  NewCategoryViewModel.swift
//  Budgetary
//
//  Created by Phillip Baker on 18/03/2026.
//

import Factory
import SwiftUI
import SwiftUINavigation

@MainActor
@Observable
final class NewCategoryViewModel {
    
    // MARK: - Stored State
    
    @ObservationIgnored private let store: AppStore
    @ObservationIgnored private let mapper: CategoriesPresentationMapper
    @ObservationIgnored private var observationTask: Task<Void, Never>?
    @ObservationIgnored private let onCategoryCreated: (TransactionCategoryPresentation) -> Void

    var destination: Destination?
    var newCategoryName: String
    var selectedGroup: CategoryGroupNamePresentation?
    private var categoryNames: [CategoryNamePresentation] = []
    
    // Set when a save is dispatched; cleared once the matching category appears in the store.
    private var pendingSaveName: String?

    let onCancel: () -> Void

    // MARK: - Destination
    
    @CasePathable
    enum Destination: Equatable {
        case groupPicker
        case nameClashAlert(AlertState<AlertAction>)
    }
    
    enum AlertAction {
        case confirm
    }
    
    // MARK: - Derived State

    var canSave: Bool {
        selectedGroup != nil && !trimmedCategoryName.isEmpty && pendingSaveName == nil
    }
    
    var isNameClash: Bool {
        let candidate = trimmedCategoryName.normalizedForComparison()
        return categoryNames
            .flatMap(\.categories)
            .contains{ $0.name.normalizedForComparison() == candidate }
    }
    
    var trimmedCategoryName: String {
        newCategoryName.trimmingCharacters(in: .whitespaces)
    }
    
    // MARK: - Init
    
    init(
        store: AppStore = Container.shared.appStore(),
        mapper: CategoriesPresentationMapper = Container.shared.categoriesPresentationMapper(),
        newCategoryName: String = "",
        onCategoryCreated: @escaping (TransactionCategoryPresentation) -> Void,
        selectedGroup: CategoryGroupNamePresentation? = nil,
        destination: Destination? = nil,
        onCancel: @escaping () -> Void
    ) {
        self.store = store
        self.mapper = mapper
        self.newCategoryName = newCategoryName
        self.onCategoryCreated = onCategoryCreated
        self.selectedGroup = selectedGroup
        self.destination = destination
        self.onCancel = onCancel
        observeStore()
    }
    
    // MARK: - Intent

    func groupPickerButtonTapped() {
        destination = .groupPicker
    }
    
    /// Called by CategoryGroupPickerRootView's onSelect closure.
    func groupSelected(_ group: CategoryGroupNamePresentation) {
        selectedGroup = group
        destination = nil
    }

    func saveButtonTapped() {
        guard canSave, let group = selectedGroup else { return }
        
        if isNameClash {
            destination = .nameClashAlert(
                AlertState {
                    TextState("A category with this name already exists in this group")
                } actions: {
                    ButtonState(action: .confirm) {
                        TextState("OK")
                    }
                } message: {
                    TextState("There is already a \(self.trimmedCategoryName) category in the monthly expenses group. Please use a different name or pick a different group.")
                }
            )
            return
        }

        pendingSaveName = trimmedCategoryName
        store.dispatch(.createCategoryRequested(name: trimmedCategoryName, groupID: ID<CategoryGroup>(group.id)))
    }
    
    func confirmAlertButtonTapped() {
        destination = nil
    }
    
    func cancelButtonTapped() {
        newCategoryName = ""
        selectedGroup = nil
        onCancel()
    }
    
    // MARK: - Store Observation
    
    private func observeStore() {
        observationTask = Task {
            for await state in store.observe() {                
                guard case .loaded(let categoryGroupRows) = state.budgetState.categoryGroupRowsState else { continue }
                let names: [CategoryNamePresentation] = mapper.map(categoryGroupRows: categoryGroupRows)
                self.categoryNames = names
                // If a save is in flight, check whether the new category has landed.
                if let pendingName = self.pendingSaveName {
                    let created = names
                        .flatMap(\.categories)
                        .first { $0.name.normalizedForComparison() == pendingName.normalizedForComparison() }
                    if let created {
                        withAnimation {
                            self.pendingSaveName = nil
                            self.onCategoryCreated(created) 
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
