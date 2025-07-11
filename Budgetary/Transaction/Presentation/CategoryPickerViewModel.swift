//
//  CategoryPickerViewModel.swift
//  Budgetary
//
//  Created by Phillip Baker on 10/05/2025.
//

import Factory
import SwiftUI

@Observable
final class CategoryPickerViewModel {
    @ObservationIgnored private let getCategoryGroupsUseCase: GetCategoryGroupsUseCase = Container.shared.getCategoryGroupsUseCase()
    @ObservationIgnored private let newCategoryUseCase: NewCategoryUseCase = Container.shared.newCategoryUseCase()
    @ObservationIgnored private let stateMapper: CategoriesStateMapper = Container.shared.categoriesStateMapper()
    
    var state: CategoryPickerState
    var searchText: String = ""
    var isFocused: Bool = true
    
    enum Destination {
        case newCategory
    }
    
    var destination: Destination? = nil
    
    init(state: CategoryPickerState = .loading) {
        self.state = state
    }
    
    @MainActor
    func handle(intent: CategoryPickerIntent) {
        Task {
            switch intent {
            case .getCategoryGroups:
                await self.getCategoryGroups()
            case .newCategory(name: let name, groupId: let groupId):
                await self.newCategoryUseCase.addCategory(with: name, toGroupWithId: groupId)
            }
        }
    }
    
    private func getCategoryGroups() async {
        let categoryGroups = await getCategoryGroupsUseCase.getCategoryGroups()
        self.state = stateMapper.map(categoryGroups: categoryGroups)
    }
    
    func newCategoryButtonTapped() {
        self.destination = .newCategory
    }
}
