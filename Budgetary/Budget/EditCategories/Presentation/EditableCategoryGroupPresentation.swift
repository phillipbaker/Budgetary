//
//  EditableCategoryGroupPresentation.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/03/2025.
//

public struct EditableCategoryGroupPresentation: Equatable, Identifiable, Sendable {
    public let id: ID<CategoryGroupPresentation>
    let name: String
    let categories: [EditableCategoryPresentation]
}
