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

    var saveIsDisabled: Bool {
        newGroupName.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    init(
        store: AppStore = Container.shared.appStore(),
        mapper: CategoriesPresentationMapper = Container.shared.categoriesPresentationMapper(),
        observationTask: Task<Void, Never>? = nil,
        onGroupCreated: @escaping (CategoryGroupNamePresentation) -> Void,
        destination: Destination? = nil,
        onCancel: @escaping () -> Void,
    ) {
        defer { observeStore() }
        self.store = store
        self.mapper = mapper
        self.observationTask = observationTask
        self.onGroupCreated = onGroupCreated
        self.destination = destination
        self.onCancel = onCancel
    }
    
    func saveButtonTapped() {
        let trimmed = newGroupName.trimmingCharacters(in: .whitespaces)
//        guard !trimmed.isEmpty else { return } // TODO: Again alert with blank text or just dismiss?
        
        // Check for name clash
        let normalizedNew = trimmed.normalizedForComparison()
        print("NormalizedNew: ", normalizedNew)
        let clash = categoryGroups
            .contains { $0.name.normalizedForComparison() == normalizedNew }
        print("Clash: ", clash)
        if clash {
            destination = .nameClashAlert(
                AlertState {
                    TextState("A category group with this name already exists")
                } actions: {
                    ButtonState(action: .confirm) {
                        TextState("OK")
                    }
                } message: {
                    TextState("There is already a \(trimmed) category group. Please use a different name or pick a different group.")
                }
            )
            return
        }

        pendingSaveName = trimmed
        store.dispatch(.newCategoryGroupRequested(trimmed))
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
