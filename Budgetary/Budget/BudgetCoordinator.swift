//
//  AppCoordinator.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/03/2025.
//

import SwiftUI
import SwiftUINavigation

@Observable
final class AppCoordinator: Identifiable {
    var path: [Destination]
    
    init(path: [Destination] = []) {
        self.path = path
    }
    
    let id = UUID()
    
    @CasePathable
    enum Destination: Hashable {
        // Transaction
        case transactionSheet
        case payeePicker
        case categoryPicker
        case accountPicker
        
        // Budget
        case monthPicker
        case editCategories

    }
}

@Observable
final class EditCategoriesCoordinator: Identifiable {
    var destination: Destination? = nil
    
    let id = UUID()

    enum Destination: Identifiable {
        case newGroup
        case newCategory(Budgetary.ID<CategoryGroupPresentation>)
        
        var id: String {
            switch self {
            case .newGroup:
                return "newGroup"
            case .newCategory(let id):
                return id.rawValue.uuidString
            }
        }
    }
    
    func newGroupButtonTapped() {
        destination = .newGroup
    }
    
    func newCategoryButtonTapped(for groupID: Budgetary.ID<CategoryGroupPresentation>) {
        destination = .newCategory(groupID)
    }
    
    func dismiss() {
        self.destination = nil
    }
}
