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
    @ObservationIgnored private let stateMapper: CategoriesStateMapper = Container.shared.categoriesStateMapper()
    
    var state: CategoryPickerState
    var searchText: String = ""
    var isFocused: Bool = true
    
    init(state: CategoryPickerState = .loading) {
        self.state = state
    }
    
    @MainActor
    func handle(intent: CategoryPickerIntent) {
        Task {
            switch intent {
            case .getCategoryGroups:
                await self.getCategoryGroups()
            }
        }
    }
    
    private func getCategoryGroups() async {
        let categoryGroups = await getCategoryGroupsUseCase.getCategoryGroups()
        self.state = stateMapper.map(categoryGroups: categoryGroups)
    }
}
