//
//  EditCategoriesRootView.swift
//  Budgetary
//
//  Created by Phillip Baker on 02/11/2024.
//

import SwiftUI

struct EditCategoriesRootView: View {
    @State var viewModel = EditCategoriesViewModel()
//    @FocusState var focusedField: EditCategoriesViewModel.FocusedField?
    
    // TODO: Figure out how to move this somehwere better
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
            // TODO: Make loading view - this one or consistent one with fields
            ProgressView()
        case .success(let categoryGroups):
            NavigationStack {
                EditCategoriesListView(
                    groups: categoryGroups,
                    intent: { intent in viewModel.handle(intent: intent) },
//                    focusedField: _focusedField,
                    resignFocus: { viewModel.resignFocus() }
                )
//                .bind($focusedField, to: $viewModel.focusedField)
                .onChange(of: viewModel.state) { _, new in
                    print("State changed: \(new)")
                }
            }
        }
    }
}
