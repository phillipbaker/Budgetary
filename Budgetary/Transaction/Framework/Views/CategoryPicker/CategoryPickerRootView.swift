//
//  CategoryPickerRootView.swift
//  Budgetary
//
//  Created by Phillip Baker on 10/05/2025.
//

import Factory
import SwiftUI

struct CategoryPickerRootView: View {
    let viewModel: CategoryPickerViewModel = Container.shared.categoryPickerViewModel()
    
    @Binding var category: TransactionCategoryPresentation?
    @Binding var destination: TransactionDetailViewModel.Destination?
    
    @FocusState var focused: Bool
    
    var body: some View {
        @Bindable var viewModel = viewModel
        Group {
            switch viewModel.state {
            case .error:
                Text("Error view goes here")
            case .loading:
                ProgressView()
            case .success(let categoryNames):
                CategoryPickerView(
                    searchText: $viewModel.searchText,
                    focused: _focused,
                    intent: { intent in viewModel.handle(intent: intent) },
                    categoryNames: categoryNames,
                    selectCategory: { category in
                        self.category = category
                        self.destination = nil
                    }
                )
                .contentMargins(.top, 12)
            }
        }
        .navigationTitle("Category")
        .task {
            viewModel.handle(intent: .getCategoryGroups)
        }
        .onAppear {
            viewModel.searchText = ""
            viewModel.isFocused = true
        }
    }
}

#Preview {
    CategoryPickerRootView(category: .constant(nil), destination: .constant(nil))
}
