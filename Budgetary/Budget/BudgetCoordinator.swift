//
//  BudgetCoordinator.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/03/2025.
//

import SwiftUINavigation
import SwiftUI

@Observable
final class BudgetCoordinator {
    var destination: Destination? = nil
    
    let id = UUID()
    
    @CasePathable
    enum Destination {
        case editCategories
        case monthPicker
        case newGroup
        case newCategory
    }
    
    func dismiss() {
        destination = nil
    }
    
    // Budget Home
    
    func editCateogoriesButtonTapped() {
        guard destination != .editCategories else { return }
        destination = .editCategories
    }
    
    func monthPickerButtonTapped() {
        guard destination != .monthPicker else { return }
        destination = .monthPicker
    }
    
    // Edit Categories
    
    func doneEditingCategoriesButtonTapped() {
        destination = nil
    }
    
    func newGroupButtonTapped() {
        destination = .newGroup
    }
    
    func newCategoryButtonTapped() {
        destination = .newCategory
    }
}
