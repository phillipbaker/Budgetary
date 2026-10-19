//
//  EditCategoryGroupRow.swift
//  Budgetary
//
//  Created by Phillip Baker on 29/09/2024.
//

import SwiftUI

struct EditCategoryGroupRow: View {
    let id: ID<CategoryGroupPresentation>
    let action: (EditCategoriesAction) -> Void
    
    @Binding var editedName: String
    @State private var displayAlert: Bool = false
    
    enum FocusedField: Hashable {
        case listRow(id: ID<CategoryGroupPresentation>)
    }
    
    var body: some View {
        TextField("Group Name", text: $editedName)
            .onSubmit {
                guard !editedName.isEmpty else {
                    displayAlert = true
                    return
                }
                action(.renameCategoryGroup(id: id, newName: editedName))
            }
            .alert(Text("Category Group name cannot be empty"), isPresented: $displayAlert) {
                Button("OK") {
                    displayAlert = false
                }
            }
            .font(.body)
            .fontWeight(.semibold)
            .textCase(.none)
            .padding(.bottom, 8)
    }
}

#Preview {
    EditCategoryGroupRow(
        id: .init(),
        action: { _ in },
        editedName: .constant("Obligations")
    )
}
