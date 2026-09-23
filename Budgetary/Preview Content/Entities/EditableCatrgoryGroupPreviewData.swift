//
//  EditCategoriesPreviewData.swift
//  Budgetary
//
//  Created by Phillip Baker on 01/04/2025.
//

import Foundation

extension EditableCategoryGroupPresentation {
    static let obligations = EditableCategoryGroupPresentation(
        id: .init(),
        name: "Obligations",
        categories: []
    )
    
    static let trueExpenses = EditableCategoryGroupPresentation(
        id: .init(),
        name: "True Expenses",
        categories: []
    )
    
    static let monthlyExpenses = EditableCategoryGroupPresentation(
        id: .init(),
        name: "Monthly Expenses",
        categories: []
    )
    
    static let fun = EditableCategoryGroupPresentation(
        id: .init(),
        name: "Fun",
        categories: []
    )
}
