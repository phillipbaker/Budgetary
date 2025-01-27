//
//  EditCategoriesView.swift
//  Budgetary
//
//  Created by Phillip Baker on 02/11/2024.
//

import SwiftUI

struct EditCategoriesView: View {
    @Bindable var viewModel: EditCategoriesViewModel
    @FocusState var focusedField: FocusedField?
    
    var body: some View {
        switch viewModel.state {
        case .empty:
            EditCategoriesEmptyView()
        case .error:
            EditCategoriesErrorView()
        case .loading:
            // TODO: Make loading view - this one or consistent one with fields
            ProgressView()
        case .success(let categoryGroups):
            Text(categoryGroups.description)
//            EditCategoriesListView(
//                groups: categoryGroups,
//                intent: { intent in viewModel.handle(intent: intent) },
//                focusedField: _focusedField,
//                resignFocus: { viewModel.resignFocus() }
//            )
//            .bind($focusedField, to: $viewModel.focusedField)
//            .onAppear {
//                viewModel.handle(intent: .loadCategoryGroups)
//            }
        }
    }
}

//#Preview {
//    EditCategoriesView(
//        viewModel: .init(
//            stateMapper: .init(mapper: .init()),
//            loadCategoryGroupsUseCase: .init(source: , mapper: .init()),
//            addCategoryUseCase: .init(source: .init(), mapper: .init()),
//            addGroupUseCase: .init(source: .init(), mapper: .init()),
//            moveCategoriesUseCase: .init(source: .init()),
//            removeCategoryUseCase: .init(source: .init()),
//            removeGroupUseCase: .init(source: .init(), mapper: .init())
//        )
//    )
//}
