//
//  EditCategoriesViewModel.swift
//  Budgetary
//
//  Created by Phillip Baker on 11/09/2024.
//

import Factory
import SwiftUI

@MainActor
@Observable
public final class EditCategoriesViewModel {
    @ObservationIgnored private let store: AppStore
    @ObservationIgnored let stateMapper: EditCategoriesStateMapper = Container.shared.editCategoriesStateMapper() // TODO: Not used right now

    var state: EditCategoriesState
    var destination: Destination?
    
    enum Destination {
        case newGroup
        case newCategory
    }
    
    init(
        store: AppStore = Container.shared.appStore(),
        state: EditCategoriesState = .loading
    ) {
        self.store = store
        self.state = state
    }

    func handle(action: EditCategoriesAction) {
        switch action {
        case .loadCategoryGroups:
            break
//            store.dispatch(.categoryGroupsDataLoadRequested)
        case let .createCategoryGroup(name):
            store.dispatch(.createCategoryGroupRequested(name))
        case let .createCategory(name: name, groupID: groupID):
            store.dispatch(.createCategoryRequested(name: name, groupID: ID<CategoryGroup>(groupID)))
        case let .renameCategoryGroup(id, newName):
            store.dispatch(.renameCategoryGroupRequested(ID<CategoryGroup>(id), newName))
        case let .renameCategory(id, newName):
            store.dispatch(.renameCategoryRequested(ID<Category>(id), newName))
        case let .deleteCategoryGroup(groupID):
            store.dispatch(.deleteCategoryGroupRequested(ID<CategoryGroup>(groupID)))
        case let .deleteCategory(categoryID, groupID):
            store.dispatch(.deleteCategoryRequested(ID<Category>(categoryID), ID<CategoryGroup>(groupID)))
        case let .moveCategoryGroup(offsets, newOffset):
            store.dispatch(.moveCategoryGroupRequested(offsets, newOffset))
        case let .moveCategory(id, destinationGroupID, index):
            store.dispatch(.moveCategoryRequested(ID<Category>(id), ID<CategoryGroup>(destinationGroupID), index))
        }
    }
}
