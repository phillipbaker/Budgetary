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
    }
}

#Preview {
    EditCategoryRow(
        id: .init(),
        action: { _ in },
        editedName: .constant("Groceries")
    )
}
