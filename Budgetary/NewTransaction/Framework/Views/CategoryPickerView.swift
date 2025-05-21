//
//  CategoryPickerView.swift
//  Budgetary
//
//  Created by Phillip Baker on 10/05/2025.
//

import Factory
import SwiftUI

struct CategoryPickerView: View {
    let viewModel: CategoryPickerViewModel = Container.shared.categoryPickerViewModel()
    
    @Binding var category: TransactionCategoryPresentation?
    @Binding var destination: NewTransactionViewModel.Destination?
    
    var body: some View {
        @Bindable var viewModel = viewModel
        Group {
            switch viewModel.state {
            case .error:
                Text("Error view goes here")
            case .loading:
                ProgressView()
            case .success(let categoryNames):
                List {
                    if !viewModel.searchText.isEmpty {
                        NewCategoryButton(searchText: viewModel.searchText) {
                            // somehow make self.category the new payee....
                            // viewModel.handle(intent: .newCategory(name: ...
                            self.category = TransactionCategoryPresentation(id: UUID().uuidString, name: viewModel.searchText)
                            self.destination = nil
                        }
                        SearchSuggestionRow(categoryNames: categoryNames, searchText: viewModel.searchText) { category in
                            self.category = category
                            self.destination = nil
                        }
                    } else {
                        CategoryNameRow(categoryNames: categoryNames) { category in
                            self.category = category
                            self.destination = nil
                        }
                    }
                }
                .contentMargins(.top, 12)
            }
        }
        .navigationTitle("Category")
        .searchable(
            text: $viewModel.searchText,
            isPresented: $viewModel.isFocused,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Choose a category"
        )
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
    CategoryPickerView(category: .constant(nil), destination: .constant(nil))
}


struct CategoryNameRow: View {
    let categoryNames: [CategoryName]
    let action: (TransactionCategoryPresentation) -> Void
    
    var body: some View {
        ForEach(categoryNames) { categoryName in
            Section {
                ForEach(categoryName.categories) { category in
                    Button {
                        action(category)
                    } label: {
                        Text(category.name)
                    }
                    .tint(.primary)
                }
            } header: {
                Text(categoryName.letter)
            }
        }
    }
}

struct SearchSuggestionRow: View {
    let categoryNames: [CategoryName]
    let searchText: String
    let action: (TransactionCategoryPresentation) -> Void

    var body: some View {
        ForEach(filteredCategories) { category in
            Button {
                action(category)
            } label: {
                Text(category.name)
            }
            .tint(.primary)
        }
    }

    var filteredCategories: [TransactionCategoryPresentation] {
        guard !searchText.isEmpty else { return [] }

        return categoryNames // [CategoryName]
            .flatMap { $0.categories } // [TransactionCategoryPresentation]
            .filter { $0.name.lowercased().contains(searchText.lowercased()) }
            .sorted { rank(text: $0.name.lowercased(), against: searchText.lowercased()) < rank(text: $1.name.lowercased(), against: searchText.lowercased()) }
    }

    // Duplicated in payee picker view - figure out where it should go
    func rank(text: String, against query: String) -> Int {
        let lowerText = text.lowercased()
        let lowerQuery = query.lowercased()

        if lowerText == lowerQuery {
            return 0  // Best match
        } else if lowerText.hasPrefix(lowerQuery) {
            return 1  // Starts with query
        } else if lowerText.contains(lowerQuery) {
            return 2  // Contains query
        } else {
            return 3  // No match
        }
    }
}

struct NewCategoryButton: View {
    var searchText: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            EmptyView()
                .overlay {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Create “\(searchText)” category")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
        }
    }
}
