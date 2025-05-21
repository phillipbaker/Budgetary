//
//  BudgetCoordinator.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/03/2025.
//

import SwiftUI
import SwiftUINavigation

@Observable
final class BudgetCoordinator: Identifiable {
    var destination: Destination? = nil
    
    let id = UUID()
    
    @CasePathable
    enum Destination {
        case editCategories
        case monthPicker

    }
    
    func editCateogoriesButtonTapped() {
        destination = .editCategories
    }
    
    func monthPickerButtonTapped() {
        destination = .monthPicker
    }
    
    func dismiss() {
        destination = nil
    }
}

@Observable
final class EditCategoriesCoordinator: Identifiable {
    var destination: Destination? = nil
    
    let id = UUID()

    enum Destination: Identifiable {
        case newGroup
        case newCategory(String)
        
        var id: String {
            switch self {
            case .newGroup:
                return "newGroup"
            case .newCategory(let id):
                return id
            }
        }
    }
    
    func newGroupButtonTapped() {
        destination = .newGroup
    }
    
    func newCategoryButtonTapped(for groupId: String) {
        destination = .newCategory(groupId)
    }
    
    func dismiss() {
        self.destination = nil
    }
}
