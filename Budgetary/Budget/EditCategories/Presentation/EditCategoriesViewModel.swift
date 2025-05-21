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
    @ObservationIgnored let loadCategoryGroupsUseCase: LoadCategoryGroupsUseCase = Container.shared.loadCategoryGroupsUseCase()
    @ObservationIgnored let newGroupUseCase: NewGroupUseCase = Container.shared.newGroupUseCase()
    @ObservationIgnored let newCategoryUseCase: NewCategoryUseCase = Container.shared.newCategoryUseCase()
    @ObservationIgnored let renameGroupUseCase: RenameGroupUseCase = Container.shared.renameGroupUseCase()
    @ObservationIgnored let renameCategoryUseCase: RenameCategoryUseCase = Container.shared.renameCategoryUseCase()
    @ObservationIgnored let removeGroupUseCase: RemoveGroupUseCase = Container.shared.removeGroupUseCase()
    @ObservationIgnored let removeCategoryUseCase: RemoveCategoryUseCase = Container.shared.removeCategoryUseCase()
    @ObservationIgnored let moveCategoryGroupUseCase: MoveCategoryGroupUseCase = Container.shared.moveCategoryGroupUseCase()
    @ObservationIgnored let moveCategoryUseCase: MoveCategoryUseCase = Container.shared.moveCategoryUseCase()

    @ObservationIgnored let stateMapper: EditCategoriesStateMapper = Container.shared.editCategoriesStateMapper()

    var state: EditCategoriesState
//    var destination: Destination?
    
//    @CasePathable
//    enum Destination {
//        case newGroup
//        case newCategory
//    }
    
    init(
        state: EditCategoriesState = .loading
//        destination: Destination? = nil
    ) {
        self.state = state
//        self.destination = destination
    }
    
    @MainActor
    func handle(intent: EditCategoriesIntent) {
        Task {
            switch intent {
            case .loadCategoryGroups:
                await loadCategoryGroups()
            case let .newGroup(name):
                await newGroupUseCase.addNew(group: name)
            case let .newCategory(name: name, groupId: id):
                await newCategoryUseCase.addCategory(with: name, toGroupWithId: id)
            case let .renameGroup(id, newName):
                await renameGroupUseCase.rename(categoryGroupWithId: id, to: newName)
            case let .renameCategory(id, newName):
                await renameCategoryUseCase.rename(categoryWithId: id, to: newName)
            case let .removeGroup(id):
                await removeGroupUseCase.removeGroup(id: id)
            case let .removeCategory(id, categoryGroup):
                await removeCategoryUseCase.removeCategory(categoryId: id, from: categoryGroup)
            case let .moveCategoryGroup(offsets, newOffset):
                await moveCategoryGroupUseCase.moveCategoryGroup(from: offsets, to: newOffset)
            case let .moveCategory(id, destinationGroupId, index):
                await moveCategoryUseCase.move(categoryId: id, to: destinationGroupId, at: index)
            }
        }
    }
    
    private var isSubscribed = false // would probably prefer to do this with Task solution but caused concurrency error

    private func loadCategoryGroups() async {
        self.state = self.stateMapper.map(editableCagtegoryGroups: await loadCategoryGroupsUseCase.load())
        
        // Only subscribe if we haven't already started a subscription
        if !isSubscribed {
            isSubscribed = true
            for await categoryGroups in await loadCategoryGroupsUseCase.subscribe() {
                // see budget view model, not handling errors and more here yet...
                self.state = self.stateMapper.map(editableCagtegoryGroups: categoryGroups)
            }
        }
    }
//    
//    func newGroupButtonTapped() {
//        self.destination = .newGroup
//    }
//    
//    func newCategoryButtonTapped() {
//        self.destination = .newCategory
//    }
//    
//    func dismiss() {
//        self.destination = nil
//    }
}
