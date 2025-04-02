//
//  EditCategoriesViewModel.swift
//  Budgetary
//
//  Created by Phillip Baker on 11/09/2024.
//

import Factory
import SwiftUI

@Observable
public final class EditCategoriesViewModel: Identifiable {
    @ObservationIgnored let stateMapper: EditCategoriesStateMapper = Container.shared.editCategoriesStateMapper()
    @ObservationIgnored let loadCategoryGroupsUseCase: LoadCategoryGroupsUseCase = Container.shared.loadCategoryGroupsUseCase()
    
//    @ObservationIgnored let addCategoryUseCase: AddCategoryUseCase
//    @ObservationIgnored let addGroupUseCase: AddGroupUseCase
//    @ObservationIgnored let moveCategoriesUseCase: MoveCategoriesUseCase
//    @ObservationIgnored let removeCategoryUseCase: RemoveCategoryUseCase
//    @ObservationIgnored let removeGroupUseCase: RemoveGroupUseCase
    @ObservationIgnored let renameCategoryUseCase = Container.shared.renameCategoryUseCase()
//    @ObservationIgnored let renameGroupUseCase: RenameGroupUseCase
//    @ObservationIgnored let reorderCategoriesUseCase: ReorderCategoriesUseCase
//    @ObservationIgnored let reorderGroupsUseCase: ReorderGroupsUseCase
    
    public enum FocusedField: Hashable {
        case listRow(String)
    }
//    
    var focusedField: FocusedField?
    var state: EditCategoriesState
    
    init(
//        focusedField: FocusedField? = nil,
        state: EditCategoriesState = .loading
    ) {
//        self.focusedField = focusedField
        self.state = state
    }
    
    @MainActor
    func handle(intent: EditCategoriesIntent) {
        Task {
            switch intent {
            case .loadCategoryGroups:
                self.state = self.stateMapper.map(editableCagtegoryGroups: await loadCategoryGroupsUseCase.load())
                //        case let .addCategory(id):
                //            addCategory(toGroupWithId: id)
                //        case .addGroup:
                //            addGroup()
                //        case .moveCategories(_, _):
                //            // TODO: Should this be combined with ReorderCategories (and just called Move?)? No, fill out
                //            break
                //        case let .removeCategory(categoryId, groupId):
                //            removeCategoryUseCase.removeCategory(id: categoryId, from: groupId)
                //        case let .removeGroup(id):
                //            removeGroupUseCase.removeGroup(id: id)
            case let .renameCategory(id, newName):
                print("rename category called in view model")
                await renameCategoryUseCase.renameCategory(withId: id, to: newName)
                //        case let .renameGroup(group, name):
                //            renameGroupUseCase.rename(group, to: name)
                //        case let .reorderCategories(group, offsets, destination):
                //            reorderCategoriesUseCase.moveCategories(in: group, from: offsets, to: destination)
                //        case let .reorderGroups(offsets, destination):
                //            reorderGroupsUseCase.moveGroups(from: offsets, to: destination)
            }
        }
    }
    
//    private func addCategory(toGroupWithId id: String) {
//        let newCategory = addCategoryUseCase.addCategory(toGroupWithId: id)
//        focusedField = .listRow(newCategory.id)
//    }
    
    private func addGroup() {
//        let newGroup = addGroupUseCase.addGroup()
//        focusedField = .listRow(newGroup.id)
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
//        focusedField = nil
    }
}
