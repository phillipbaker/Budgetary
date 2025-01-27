//
//  EditCategoriesViewModel.swift
//  Budgetary
//
//  Created by Phillip Baker on 11/09/2024.
//

import Dependencies
import SwiftUI

public enum FocusedField: Hashable {
    case listRow(String)
}

@Observable
public final class EditCategoriesViewModel: Identifiable {
    // TODO: Register all dependencies
    @ObservationIgnored var stateMapper: EditCategoriesStateMapper
    @ObservationIgnored var loadCategoryGroupsUseCase: LoadCategoryGroupsUseCase
    @ObservationIgnored var addCategoryUseCase: AddCategoryUseCase
    @ObservationIgnored var addGroupUseCase: AddGroupUseCase
    @ObservationIgnored var moveCategoriesUseCase: MoveCategoriesUseCase
    @ObservationIgnored var removeCategoryUseCase: RemoveCategoryUseCase
    @ObservationIgnored var removeGroupUseCase: RemoveGroupUseCase
    @ObservationIgnored var renameCategoryUseCase: RenameCategoryUseCase
    @ObservationIgnored var renameGroupUseCase: RenameGroupUseCase
    @ObservationIgnored var reorderCategoriesUseCase: ReorderCategoriesUseCase
    @ObservationIgnored var reorderGroupsUseCase: ReorderGroupsUseCase
    
    var focusedField: FocusedField?
    var state: EditCategoriesState
    
    init(
        stateMapper: EditCategoriesStateMapper = EditCategoriesStateMapper(mapper: BudgetPresentationMapper()),
        loadCategoryGroupsUseCase: LoadCategoryGroupsUseCase = LoadCategoryGroupsUseCase(
            source: LoadCategoryGroupsSourceCombined(),
            mapper: BudgetMapper()
        ),
        addCategoryUseCase: AddCategoryUseCase = .init(source: AddCategorySourceData(), mapper: BudgetMapper()),
        addGroupUseCase: AddGroupUseCase = .init(source: AddGroupSourceImpl(), mapper: BudgetMapper()),
        moveCategoriesUseCase: MoveCategoriesUseCase = .init(source: MoveCategoriesSourceImpl()),
        removeCategoryUseCase: RemoveCategoryUseCase = .init(source: RemoveCategorySourceImpl(), mapper: BudgetMapper()),
        removeGroupUseCase: RemoveGroupUseCase = .init(source: RemoveGroupSourceImpl(), mapper: BudgetMapper()),
        renameCategoryUseCase: RenameCategoryUseCase = .init(source: RenameCategorySourceImpl(), mapper: BudgetMapper()),
        renameGroupUseCase: RenameGroupUseCase = .init(source: RenameGroupSourceImpl(), mapper: BudgetMapper()),
        reorderCategoriesUseCase: ReorderCategoriesUseCase = .init(source: ReorderCategoriesSourceImpl(), mapper: BudgetMapper()),
        reorderGroupsUseCase: ReorderGroupsUseCase = .init(source: ReorderGroupsSourceImpl(), mapper: BudgetMapper()),
        focusedField: FocusedField? = nil,
        state: EditCategoriesState = .loading
    ) {
        self.stateMapper = stateMapper
        self.loadCategoryGroupsUseCase = loadCategoryGroupsUseCase
        self.addCategoryUseCase = addCategoryUseCase
        self.addGroupUseCase = addGroupUseCase
        self.moveCategoriesUseCase = moveCategoriesUseCase
        self.removeCategoryUseCase = removeCategoryUseCase
        self.removeGroupUseCase = removeGroupUseCase
        self.renameCategoryUseCase = renameCategoryUseCase
        self.renameGroupUseCase = renameGroupUseCase
        self.reorderCategoriesUseCase = reorderCategoriesUseCase
        self.reorderGroupsUseCase = reorderGroupsUseCase
        self.focusedField = focusedField
        self.state = state
    }
    
    func handle(intent: EditCategoriesIntent) {
        switch intent {
        case .loadCategoryGroups:
            loadCategoryGroups()
        case let .addCategory(id):
            addCategory(toGroupWithId: id)
        case .addGroup:
            addGroup()
        case .moveCategories(_, _):
            // TODO: Should this be combined with ReorderCategories (and just called Move?)? No, fill out
            break
        case let .removeCategory(categoryId, groupId):
            removeCategoryUseCase.removeCategory(id: categoryId, from: groupId)
        case let .removeGroup(id):
            removeGroupUseCase.removeGroup(id: id)
        case let .renameCategory(category, name):
            renameCategoryUseCase.rename(category, to: name)
        case let .renameGroup(group, name):
            renameGroupUseCase.rename(group, to: name)
        case let .reorderCategories(group, offsets, destination):
            reorderCategoriesUseCase.moveCategories(in: group, from: offsets, to: destination)
        case let .reorderGroups(offsets, destination):
            reorderGroupsUseCase.moveGroups(from: offsets, to: destination)
        }
    }
    
    private func loadCategoryGroups() {
        loadCategoryGroupsUseCase.load()
    }
    
    private func addCategory(toGroupWithId id: String) {
        let newCategory = addCategoryUseCase.addCategory(toGroupWithId: id)
        focusedField = .listRow(newCategory.id)
    }
    
    private func addGroup() {
        let newGroup = addGroupUseCase.addGroup()
        focusedField = .listRow(newGroup.id)
        //        if let emptyRow = groups.first(where: { $0.name.isEmpty }) {
        //            focusedField = .listRow(emptyRow.id)
        //        } else {
        //            let newGroup = CategoryGroupPresentation()
        //            groups.insert(newGroup, at: 0)
        //            focusedField = .listRow(newGroup.id)
        //        }
        //    }
    }
    
    private func update(_ category: CategoryPresentation) {
        // apply edits to name, hide/unhide, notes all at once? How will that work?
    }
    
    func resignFocus() {
        focusedField = nil
    }
}
