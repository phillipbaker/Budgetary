//
//  CategoryPickerView.swift
//  Budgetary
//
//  Created by Phillip Baker on 12/06/2025.
//

import SwiftUI

struct CategoryPickerView: View {
    @Binding var searchText: String
    @FocusState var focused: Bool
    @State private var groupId: String? = nil
    let intent: (CategoryPickerIntent) -> Void
    let categoryNames: [CategoryName]
    let selectCategory: (TransactionCategoryPresentation) -> Void
    
    @State private var newCategorySheetIsPresented: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            SearchField(
                title: "Find or add a category",
                searchText: $searchText,
                focused: _focused
            )
            .background(Color(.systemGroupedBackground))
            
            List {
                if !searchText.isEmpty {
                    NewCategoryButton(
                        action: { newCategorySheetIsPresented = true },
                        searchText: searchText
                    )

                    ForEach(filteredCategories) { category in
                        CategoryNameRow(
                            action: selectCategory,
                            category: category
                        )
                    }
                } else {
                    ForEach(categoryNames) { categoryName in
                        Section {
                            ForEach(categoryName.categories) { category in
                                CategoryNameRow(
                                    action: selectCategory,
                                    category: category
                                )
                            }
                        } header: {
                            Text(categoryName.letter)
                        }
                    }
                }
            }
            .scrollDismissesKeyboard(.immediately)
            
            var filteredCategories: [TransactionCategoryPresentation] {
                guard !searchText.isEmpty else { return [] }
                
                return categoryNames // [CategoryName]
                    .flatMap { $0.categories } // [TransactionCategoryPresentation]
                    .filter { $0.name.lowercased().contains(searchText.lowercased()) }
                    .sorted { $0.name.rankedAgainst(text: searchText) < $1.name.rankedAgainst(text: searchText) }
            }
        }
        .sheet(isPresented: $newCategorySheetIsPresented) {
            NavigationStack {
                NewCategoryInGroupView(name: searchText)
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("Save") {
                                
                                newCategorySheetIsPresented = false
                            }
                            .fontWeight(.semibold)
                            .disabled(groupId == nil)
                        }
                        
                        ToolbarItem(placement: .topBarLeading) {
                            Button("Cancel") {
                                newCategorySheetIsPresented = false
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    @Previewable @State var searchText: String = ""
    CategoryPickerView(
        searchText: $searchText,
        intent: { _ in },
//        groupId: nil,
        categoryNames: [],
        selectCategory: { _ in }
    )
}
