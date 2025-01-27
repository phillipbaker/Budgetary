//
//  EditCategoriesState.swift
//  Budgetary
//
//  Created by Phillip Baker on 02/11/2024.
//

public enum EditCategoriesState {
    case empty
    case error
    case loading
    case success([CategoryGroupPresentation])
}
