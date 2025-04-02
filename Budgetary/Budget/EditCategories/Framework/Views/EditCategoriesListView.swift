//
//  EditCategoriesListView.swift
//  Budgetary
//
//  Created by Phillip Baker on 10/09/2024.
//

import SwiftUI

struct EditCategoriesListView: View {
    @Environment(BudgetCoordinator.self) var coordinator
//    @Bindable var viewModel: EditCategoriesViewModel
    
    let groups: [EditableCategoryGroupPresentation]
    let intent: (EditCategoriesIntent) -> Void
    
    @State private var localValues: [String: String] = [:]
    
//    @FocusState var focusedField: EditCategoriesViewModel.FocusedField?
    let resignFocus: () -> Void

    var body: some View {
        List {
            Button("Add Group") {
//                withAnimation { intent(.addGroup) }
            }
            ForEach(groups) { group in
                Section {
                    ForEach(group.categories) { category in
                        EditCategoryRow(
                            id: category.id,
                            intent: intent,
                            editedName: bindingFor(category: category)
                            //                            focusedField: _focusedField
                        )
                    }
                    .onMove { _, _ in
                        //                        intent(.reorderCategories(group, source, destination))
                    }
                } header: {
                    EditCategoryGroupRow(
                        group: group,
                        intent: { _ in /*rowIntent in intent(rowIntent)*/ },
                        editedName: group.name
//                        focusedField: _focusedField
                    )
//                    .background(
//                        focusedField == .listRow(group.id)
//                        ? Color(.systemFill)
//                        : Color.clear
//                    )
                }
            }
//            .onMove { source, destination in
////                intent(.reorderGroups(source, destination))
//            }
        }
        .padding(.horizontal, 8)
        .listStyle(.plain)
        
        .onTapGesture {
//            resignFocus()
        }
        
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                DoneButton(onSubmit: coordinator.doneEditingCategoriesButtonTapped)
            }
        }
    }
    
    private func bindingFor(category: EditableCategoryPresentation) -> Binding<String> {
        return Binding(
            get: { localValues[category.id, default: category.name] },
            set: { localValues[category.id] = $0 }
        )
    }
}

#Preview {
    EditCategoriesListView(
        groups: [EditableCategoryGroupPresentation.obligations, .trueExpenses, .monthlyExpenses, .fun],
        intent: { _ in },
        resignFocus: {}
    )
}
