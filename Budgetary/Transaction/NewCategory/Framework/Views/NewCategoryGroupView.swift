//
//  NewCategoryGroupView.swift
//  Budgetary
//
//  Created by Phillip Baker on 18/03/2026.
//

import SwiftUI
import SwiftUINavigation

struct NewCategoryGroupView: View {
    @State var model: NewCategoryGroupViewModel
    @FocusState private var nameIsFocused: Bool
    
    init(
        onGroupCreated: @escaping (CategoryGroupNamePresentation) -> Void,
        onCancel: @escaping () -> Void
    ) {
        _model = State(wrappedValue: NewCategoryGroupViewModel(
            onGroupCreated: onGroupCreated,
            onCancel: onCancel
        ))
    }
    
    var body: some View {
        Form {
            TextField("New Category Group", text: $model.newGroupName)
                .focused($nameIsFocused)
                .onSubmit {
                    model.saveButtonTapped()
                }
        }
        .navigationTitle("New Category Group")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(role: .cancel) {
                    model.cancelButtonTapped()
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button(role: .confirm) {
                    model.saveButtonTapped()
                }
                .disabled(!model.canSave)
            }
        }
        .alert($model.destination.nameClashAlert) { _ in
            model.confirmAlertButtonTapped()
        }
        .onAppear {
            if model.newGroupName.isEmpty {
                nameIsFocused = true
            }
        }
    }
}

#Preview {
    NewCategoryGroupView(onGroupCreated: { _ in }, onCancel: {})
}
