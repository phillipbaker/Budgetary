//
//  EditCategoriesRootView.swift
//  Budgetary
//
//  Created by Phillip Baker on 02/11/2024.
//

import Factory
import SwiftUI

struct EditCategoriesRootView: View {
    let viewModel: EditCategoriesViewModel = Container.shared.editCategoriesViewModel()
    
    init() {
        viewModel.handle(intent: .loadCategoryGroups)
    }
    
    var body: some View {
        switch viewModel.state {
        case .empty:
            EditCategoriesEmptyView()
        case .error:
            EditCategoriesErrorView()
        case .loading:
            ProgressView()
        case .success(let categoryGroups):
            NavigationStack {
                EditCategoriesListView(
                    categoryGroups: categoryGroups,
                    intent: { intent in viewModel.handle(intent: intent) }
                )
            }
        }
    }
}
