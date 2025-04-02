//
//  EditCategoriesIntent.swift
//  Budgetary
//
//  Created by Phillip Baker on 01/11/2024.
//

import Foundation

public enum EditCategoriesIntent {
    case loadCategoryGroups
//    case addCategory(id: String)
//    case addGroup
//    case moveCategories([CategoryPresentation], CategoryGroupPresentation)
//    case removeCategory(id: String, groupId: String)
//    case removeGroup(id: String)
    case renameCategory(id: String, newName: String)
//    case renameGroup(CategoryGroupPresentation, String)
//    case reorderCategories(CategoryGroupPresentation, IndexSet, Int)
//    case reorderGroups(IndexSet, Int)
}
