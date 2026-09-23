//
//  EditableCategory.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/03/2025.
//

public struct EditableCategory: Equatable, Sendable {
    let id: ID<EditableCategory>
    let name: String
    
    func rename(to newName: String) -> EditableCategory {
        return EditableCategory(id: self.id, name: newName)
    }
}
