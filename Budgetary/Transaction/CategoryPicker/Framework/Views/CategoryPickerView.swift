//
//  CategoryPickerView.swift
//  Budgetary
//
//  Created by Phillip Baker on 12/06/2025.
//

import SwiftUI

struct CategoryPickerView: View {
    @Bindable var model: CategoryPickerViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            SearchField(
                title: "Find or add a category",
                searchText: $model.searchText
            )
            .background(Color(.systemGroupedBackground))
            
            List {
                if !model.isSearching {
                    AddItemButton("New Category") {
                        model.newCategoryButtonTapped()
                    }
                    
                    ForEach(model.categoryNames) { categoryName in
                        Section {
                            ForEach(categoryName.categories) { category in
                                CategoryNameRow(
                                    category: category,
                                    onSelect: model.selectCategoryButtonTapped
                                )
                            }
                        } header: {
                            Text(categoryName.letter)
                        }
                    }
                } else {
                    if !model.isNameClash {
                        AddItemButton("Create “\(model.trimmedSearchText)” Category") {
                            model.newCategoryButtonTapped()
                        }
                    }
                    
                    ForEach(model.filteredCategories) { category in
                        CategoryNameRow(
                            category: category,
                            onSelect: model.selectCategoryButtonTapped
                        )
                    }
                }
            }
        }
        .contentMargins(.top, 12)
        .navigationTitle("Category")
        .scrollDismissesKeyboard(.immediately)
        .sheet(isPresented: $model.newCategorySheetIsPresented) {
            NavigationStack {
                NewCategoryView(
                    newCategoryName: model.trimmedSearchText,
                    onCategoryCreated: model.onCategoryCreated,
                    onCancel: model.cancelNewCategoryButtonTapped
                )
            }
        }
    }
}

#Preview {
    CategoryPickerView(model: .init(onSelect: { _ in }))
}
