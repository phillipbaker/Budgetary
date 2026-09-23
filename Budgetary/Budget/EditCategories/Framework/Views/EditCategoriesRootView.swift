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
    let coordinator: EditCategoriesCoordinator = Container.shared.editCategoriesCoordinator()
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .empty:
                EditCategoriesEmptyView()
            case .error:
                EditCategoriesErrorView()
            case .loading:
                ProgressView()
            case .success(let categoryGroups):
                EditCategoriesListView(
                    action: { action in viewModel.handle(action: action) },
                    coordinator: coordinator,
                    categoryGroups: categoryGroups
                )
                .environment(coordinator)
            }
        }
        .task {
            viewModel.handle(action: .loadCategoryGroups)
        }
    }
}
