//
//  EditCategoriesAction.swift
//  Budgetary
//
//  Created by Phillip Baker on 01/11/2024.
//

import Foundation

public enum EditCategoriesAction {
    case loadCategoryGroups
    case createCategoryGroup(name: String)
    case createCategory(name: String, groupID: ID<CategoryGroupPresentation>)
    case renameCategoryGroup(id: ID<CategoryGroupPresentation>, newName: String)
    case renameCategory(id: ID<EditableCategoryPresentation>, newName: String)
    case deleteCategoryGroup(id: ID<CategoryGroupPresentation>)
    case deleteCategory(id: ID<EditableCategoryPresentation> , groupID: ID<CategoryGroupPresentation>)
    case moveCategoryGroup(from: IndexSet, to: Int)
    case moveCategory(id: ID<EditableCategoryPresentation> , toDestinationGroupID: ID<CategoryGroupPresentation>, atIndex: Int)
}
