//
//  EditCategoriesListView.swift
//  Budgetary
//
//  Created by Phillip Baker on 10/09/2024.
//

import SwiftUI

//struct EditCategoriesListView: View {
//    var groups: [CategoryGroupPresentation]
//    var intent: (EditCategoriesIntent) -> Void
//    
//    @FocusState var focusedField: FocusedField?
//    let resignFocus: () -> Void
//
//    var body: some View {
//        List {
//            Button("Add Group") {
//                withAnimation { intent(.addGroup) }
//            }
//            ForEach(groups) { group in
//                Section {
//                    ForEach(group.categories) { category in
//                        EditCategoryRow(
//                            category: category,
//                            renameCategory: { category, newName in
//                                intent(.renameCategory(category, newName))
//                            },
//                            editedName: category.name,
//                            focusedField: _focusedField
//                        )
//                    }
//                    .onMove { source, destination in
//                        intent(.reorderCategories(group, source, destination))
//                    }
//                } header: {
//                    EditCategoryGroupRow(
//                        group: group,
//                        intent: { rowIntent in intent(rowIntent) },
//                        editedName: group.name,
//                        focusedField: _focusedField
//                    )
//                    EditCategoryGroupRow(
//                        group: group,
//                        focusedField: _focusedField,
//                        addGroup: { id in intent(.addCategory(id: id)) },
//                        removeGroup: { id in intent(.removeGroup(id: id)) }
//                    )
//                    .background(
//                        focusedField == .listRow(group.id)
//                        ? Color(.systemFill)
//                        : Color.clear
//                    )
//                }
//            }
//            .onMove { source, destination in
//                intent(.reorderGroups(source, destination))
//            }
//        }
//        .padding(.horizontal, 8)
//        .listStyle(.plain)
//        
//        .onTapGesture {
//            resignFocus()
//        }
//    }
//}
//
//#Preview {
//    EditCategoriesListView(
//        groups: [.obligations, .trueExpenses, .monthlyExpenses, .fun],
//        intent: { _ in },
//        resignFocus: {}
//    )
//}
