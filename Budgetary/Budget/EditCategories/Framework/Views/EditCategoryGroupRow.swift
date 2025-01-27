//
//  EditCategoryGroupRow.swift
//  Budgetary
//
//  Created by Phillip Baker on 29/09/2024.
//

import SwiftUI

struct EditCategoryGroupRow: View {
    // TODO: Just id here instead of whole group?
    let group: CategoryGroupPresentation
    let intent: (EditCategoriesIntent) -> Void
    @State var editedName: String
    @FocusState var focusedField: FocusedField?
    
    var body: some View {
        HStack {
            TextField("Group Name", text: $editedName)
                .focused($focusedField, equals: .listRow(group.id))
                .onChange(of: focusedField) { oldValue, _ in
                    if oldValue == .listRow(group.id) {
                        if editedName.isEmpty && group.categories.isEmpty {
                            withAnimation {
                                intent(.removeGroup(id: group.id))
                            }
                        }
                    }
                }
                .onSubmit {
                    intent(.renameGroup(group, editedName))
                }
                .font(.body)
                .fontWeight(.semibold)
            
            Button {
                withAnimation { intent(.addGroup) }
            } label: {
                Image(systemName: "plus.circle")
                    .tint(.secondary)
            }
            .buttonStyle(.borderless)
            
            Image(systemName: "line.3.horizontal")
                .foregroundStyle(.secondary)
                .imageScale(.large)
        }
        .padding(.bottom, 8)
    }
}

#Preview {
    EditCategoryGroupRow(
        group: .obligations,
        intent: { _ in }, 
        editedName: "Obligations"
    )
}
