//
//  EditCategoryRow.swift
//  Budgetary
//
//  Created by Phillip Baker on 29/09/2024.
//

import SwiftUI

struct EditCategoryRow: View {
    // TODO: Just id here instead of whole category?
    var category: CategoryPresentation
    var renameCategory: (CategoryPresentation, String) -> Void
    @State var editedName: String
    @FocusState var focusedField: FocusedField?
    
    var body: some View {
        HStack {
            TextField("Category Name", text: $editedName)
                .focused($focusedField, equals: .listRow(category.id))
                .textFieldStyle(.roundedBorder)
                .transition(.scale)
                .onSubmit { renameCategory(category, editedName) }
            
            Image(systemName: "line.3.horizontal")
                .foregroundStyle(.tertiary)
                .imageScale(.large)
        }
        .listRowSeparator(.hidden)
        .listRowBackground(
            focusedField == .listRow(category.id)
            ? Color(.blue.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            : Color.clear
                .clipShape(RoundedRectangle(cornerRadius: 8))
        )
    }
}

#Preview {
    EditCategoryRow(
        category: .groceries,
        renameCategory: { _,_ in },
        editedName: "Groceries"
    )
}
