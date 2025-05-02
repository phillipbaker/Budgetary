//
//  EditCategoriesIntent.swift
//  Budgetary
//
//  Created by Phillip Baker on 01/11/2024.
//

import Foundation

public enum EditCategoriesIntent {
    case loadCategoryGroups
    case newGroup(name: String)
    case newCategory(name: String, groupId: String)
    case renameGroup(id: String, newName: String)
    case renameCategory(id: String, newName: String)
    case removeGroup(id: String)
    case removeCategory(id: String, groupId: String)
    case moveCategoryGroup(from: IndexSet, to: Int)
    case moveCategory(id: String, toDestinationGroupId: String, atIndex: Int)
}
