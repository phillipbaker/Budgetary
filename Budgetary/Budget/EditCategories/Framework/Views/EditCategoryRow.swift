//
//  EditCategoryRow.swift
//  Budgetary
//
//  Created by Phillip Baker on 29/09/2024.
//

import SwiftUI

struct EditCategoryRow: View {
    let id: ID<EditableCategoryPresentation>
    let action: (EditCategoriesAction) -> Void

    @Binding var editedName: String
    @FocusState var focus: FocusedField?
    @State private var displayAlert: Bool = false

    enum FocusedField: Hashable {
        case listRow(id: String)
    }

    var body: some View {
        Text(editedName)
//        TextField("Category Name", text: $editedName)
//            .focused($focus, equals: .listRow(id: id))
//            .listRowBackground(
//                focus == .listRow(id: id)
//                ? Color(.blue.opacity(0.08))
//                : nil
//            )
//            .onSubmit {
//                guard !editedName.isEmpty else {
//                    focus = .listRow(id: id)
//                    displayAlert = true
//                    return
//                }
//                action(.renameCategory(id: id, newName: editedName))
//            }
//            .alert(Text("Category name cannot be empty"), isPresented: $displayAlert) {
//                Button("OK") {
//                    displayAlert = false
//                }
//            }
    }
}

#Preview {
    EditCategoryRow(
        id: .init(),
        action: { _ in },
        editedName: .constant("Groceries")
    )
}
