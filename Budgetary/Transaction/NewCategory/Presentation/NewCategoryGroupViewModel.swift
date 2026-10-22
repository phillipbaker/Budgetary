//
//  NewCategoryGroupViewModel.swift
//  Budgetary
//
//  Created by Phillip Baker on 24/04/2026.
//

import Factory
import SwiftUI
import SwiftUINavigation

@MainActor
@Observable
final public class NewCategoryGroupViewModel {

    // MARK: - Stored State
    
    @ObservationIgnored private let store: AppStore
    @ObservationIgnored private let mapper: CategoriesPresentationMapper
    @ObservationIgnored private var observationTask: Task<Void, Never>?
    @ObservationIgnored private let onGroupCreated: (CategoryGroupNamePresentation) -> Void
    
    var destination: Destination?
    var newGroupName: String = ""
    var categoryGroups: [CategoryGroupNamePresentation] = []
    
    let onCancel: () -> Void
    
    // Set when a save is dispatched; cleared once the matching category appears in the store.
    private var pendingSaveName: String?

    // MARK: - Destination
    
    @CasePathable
    enum Destination: Equatable {
        case nameClashAlert(AlertState<AlertAction>)
    }

    enum AlertAction {
        case confirm
    }
    
    // MARK: - Derived State

    var canSave: Bool {
        !trimmedGroupName.isEmpty && pendingSaveName == nil
    }
    
    var isNameClash: Bool {
        let candidate = trimmedGroupName.normalizedForComparison()
        return categoryGroups
            .contains { $0.name.normalizedForComparison() == candidate }
    }
    
    var trimmedGroupName: String {
        newGroupName.trimmingCharacters(in: .whitespaces)
    }
    
    init(
        store: AppStore = Container.shared.appStore(),
        mapper: CategoriesPresentationMapper = Container.shared.categoriesPresentationMapper(),
        onGroupCreated: @escaping (CategoryGroupNamePresentation) -> Void,
        destination: Destination? = nil,
        onCancel: @escaping () -> Void,
    ) {
        defer { observeStore() }
        self.store = store
        self.mapper = mapper
        self.onGroupCreated = onGroupCreated
        self.destination = destination
        self.onCancel = onCancel
    }
    
    func saveButtonTapped() {
        guard canSave else { return }
        
        if isNameClash {
            destination = .nameClashAlert(
                AlertState {
                    TextState("A category group with this name already exists")
                } actions: {
                    ButtonState(action: .confirm) {
                        TextState("OK")
                    }
                } message: {
                    TextState("There is already a \(self.trimmedGroupName) category group. Please use a different name or pick a different group.")
                }
            )
            return
        }

        pendingSaveName = trimmedGroupName
        store.dispatch(.createCategoryGroupRequested(trimmedGroupName))
    }
    
    func confirmAlertButtonTapped() {
        destination = nil
    }
    
    func cancelButtonTapped() {
        newGroupName = ""
        onCancel()
    }
    
    private func observeStore() {
        observationTask = Task {
            for await state in store.observe() {
                guard case .loaded(let categoryGroupRows) = state.budgetState.categoryGroupRowsState else { continue }
                let categoryGroups: [CategoryGroupNamePresentation] = mapper.map(categoryGroupRows: categoryGroupRows)
                self.categoryGroups = categoryGroups
                // If a save is in flight, check whether the new group has landed.
                if let pendingName = self.pendingSaveName {
                    let created = categoryGroups
                        .first { $0.name.normalizedForComparison() == pendingName.normalizedForComparison() }
                    if let created {
                        withAnimation {
                            self.pendingSaveName = nil
                            self.onGroupCreated(created)
                        }
                    }
                }
            }
        }
    }
}
