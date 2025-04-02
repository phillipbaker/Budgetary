//
//  EditCategoriesPreviewData.swift
//  Budgetary
//
//  Created by Phillip Baker on 01/04/2025.
//

import Foundation

extension EditableCategoryGroupPresentation {
    static let obligations = EditableCategoryGroupPresentation(
        id: UUID().uuidString,
        name: "Obligations",
        categories: []
    )
    
    static let trueExpenses = EditableCategoryGroupPresentation(
        id: UUID().uuidString,
        name: "True Expenses",
        categories: []
    )
    
    static let monthlyExpenses = EditableCategoryGroupPresentation(
        id: UUID().uuidString,
        name: "Monthly Expenses",
        categories: []
    )
    
    static let fun = EditableCategoryGroupPresentation(
        id: UUID().uuidString,
        name: "Fun",
        categories: []
    )
}
