//
//  NewCategoryView.swift
//  Budgetary
//
//  Created by Phillip Baker on 13/06/2025.
//

import SwiftUI
import SwiftUINavigation

struct NewCategoryView: View {
    @State private var viewModel: NewCategoryViewModel
    @FocusState private var nameIsFocused: Bool

    init(
        newCategoryName: String = "",
        onCategoryCreated: @escaping (TransactionCategoryPresentation) -> Void,
        onCancel: @escaping () -> Void
    ) {
        _viewModel = State(
            wrappedValue: NewCategoryViewModel(
                newCategoryName: newCategoryName,
                onCategoryCreated: onCategoryCreated,
                onCancel: onCancel
            )
        )
    }

    var body: some View {
        @Bindable var model = viewModel
        Form {
            Section {
                VStack(alignment: .leading) {
                    if !model.newCategoryName.isEmpty {
                        Text("Category Name")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    TextField("New Category Name", text: $model.newCategoryName)
                        .focused($nameIsFocused)
                }
            }

            Section {
                Button {
                    model.groupPickerButtonTapped()
                } label: {
                    VStack(alignment: .leading, spacing: 8) {
                        if model.selectedGroup != nil {
                            Text("Category Group")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        Text(model.selectedGroup?.name ?? "Choose Category Group...")
                    }
                }
                .tint(.primary)
            }
        }
        .navigationTitle("New Category")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(role: .confirm) {
                    model.saveButtonTapped()
                }
                .fontWeight(.semibold)
                .disabled(!model.canSave)
            }
            ToolbarItem(placement: .topBarLeading) {
                Button(role: .cancel) {
                    model.cancelButtonTapped()
                }
            }
        }
        .sheet(isPresented: Binding<Bool>(
            get: { model.destination == .groupPicker },
            set: { model.destination = $0 ? .groupPicker : nil }
        )) {
            NavigationStack {
                CategoryGroupPickerRootView(
                    selectedGroup: model.selectedGroup,
                    onSelect: model.groupSelected
                )
                .navigationTitle(model.newCategoryName.isEmpty ? "Choose Category Group" : "Category Group for \(model.newCategoryName)")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(role: .cancel) {
                            model.cancelButtonTapped()
                        }
                    }
                }
            }
        }
        .alert($model.destination.nameClashAlert) { _ in
            model.confirmAlertButtonTapped()
        }
        .onAppear {
            if model.newCategoryName.isEmpty {
                nameIsFocused = true
            }
        }
    }
}

#Preview {
    NewCategoryView(
        onCategoryCreated: { _ in },
        onCancel: {}
    )
}
