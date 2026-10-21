//
//  EditableCategoryGroup.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/03/2025.
//

public struct EditableCategoryGroup: Equatable, Sendable {
    let id: ID<EditableCategoryGroup>
    let name: String
    let categories: [EditableCategory]
    
    func renameCategoryGroup(to newName: String) -> EditableCategoryGroup {
        return EditableCategoryGroup(id: self.id, name: newName, categories: self.categories)
    }
}
