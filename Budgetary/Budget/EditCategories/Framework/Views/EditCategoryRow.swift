//
//  EditCategoryRow.swift
//  Budgetary
//
//  Created by Phillip Baker on 29/09/2024.
//

import SwiftUI

struct EditCategoryRow: View {
    let id: String
    let intent: (EditCategoriesIntent) -> Void
    @Binding var editedName: String
//    @FocusState var focusedField: EditCategoriesViewModel.FocusedField?
    
    var body: some View {
        HStack {
            TextField("Category Name", text: $editedName)
//                .focused($focusedField, equals: .listRow(id))
                .textFieldStyle(.roundedBorder)
                .transition(.scale)
                .onSubmit {
                    print("onSubmit called")
                    intent(.renameCategory(id: id, newName: editedName))
                }
            
            Image(systemName: "line.3.horizontal")
                .foregroundStyle(.tertiary)
                .imageScale(.large)
        }
        .listRowSeparator(.hidden)
//        .listRowBackground(
//            focusedField == .listRow(id)
//            ? Color(.blue.opacity(0.2))
//                .clipShape(RoundedRectangle(cornerRadius: 8))
//            : Color.clear
//                .clipShape(RoundedRectangle(cornerRadius: 8))
//        )
    }
}

#Preview {
    EditCategoryRow(
        id: UUID().uuidString,
        intent: { _ in },
        editedName: .constant("Groceries")
    )
}
