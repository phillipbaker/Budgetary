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
    
    @CasePathable
    enum Destination {
        case editCategories
        case monthPicker
    }
    
    func editCateogoriesButtonTapped() {
        guard destination != .editCategories else { return }
        destination = .editCategories
    }
    
    func monthPickerButtonTapped() {
        guard destination != .monthPicker else { return }
        destination = .monthPicker
    }
    
    func doneEditingCategoriesButtonTapped() {
        destination = nil
    }
}
