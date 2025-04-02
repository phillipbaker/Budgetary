//
//  EditCategoriesState.swift
//  Budgetary
//
//  Created by Phillip Baker on 02/11/2024.
//

public enum EditCategoriesState: Equatable {
    case empty
    case error
    case loading
    case success([EditableCategoryGroupPresentation])
}
