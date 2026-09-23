//
//  EditCategoriesAction.swift
//  Budgetary
//
//  Created by Phillip Baker on 01/11/2024.
//

import Foundation

public enum EditCategoriesAction {
    case loadCategoryGroups
    case newGroup(name: String)
    case newCategory(name: String, groupID: ID<CategoryGroupPresentation>)
    case renameGroup(id: ID<CategoryGroupPresentation>, newName: String)
    case renameCategory(id: ID<EditableCategoryPresentation>, newName: String)
    case removeGroup(id: ID<CategoryGroupPresentation>)
    case removeCategory(id: ID<EditableCategoryPresentation> , groupID: ID<CategoryGroupPresentation>)
    case moveCategoryGroup(from: IndexSet, to: Int)
    case moveCategory(id: ID<EditableCategoryPresentation> , toDestinationGroupID: ID<CategoryGroupPresentation>, atIndex: Int)
}
