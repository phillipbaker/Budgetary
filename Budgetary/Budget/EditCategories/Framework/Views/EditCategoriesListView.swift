//
//  EditCategoriesListView.swift
//  Budgetary
//
//  Created by Phillip Baker on 10/09/2024.
//

import Factory
import SwiftUI
import UniformTypeIdentifiers

struct EditCategoriesListView: View {
    let intent: (EditCategoriesIntent) -> Void
    @Bindable var coordinator: EditCategoriesCoordinator
    let categoryGroups: [EditableCategoryGroupPresentation]

    @State private var localValues: [String: String] = [:]
    @State private var editMode: EditMode = .inactive
    
    var body: some View {
        List {
            HStack(spacing: 16) {
                Button {
                    coordinator.newGroupButtonTapped()
                } label: {
                    Label("New Group", systemImage: "folder.fill.badge.plus")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 4)
                }
                
                Button {
                    withAnimation {
                        editMode = .active
                    }
                } label: {
                    Label("Reorder", systemImage: "arrow.up.arrow.down")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 4)
                }
            }
            .font(.subheadline)
            .fontWeight(.semibold)
            .buttonStyle(.bordered)
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowBackground(Color.clear)
            
            ForEach(categoryGroups) { group in
                Section {
                    ForEach(group.categories) { category in
                        EditCategoryRow(
                            id: category.id,
                            intent: intent,
                            editedName: bindingFor(category: category)
                        )
                        .draggable(category)
                    }
                    .onMove { _, _ in }
                    
                    if editMode == .inactive {
                        Button {
                            coordinator.newCategoryButtonTapped(for: group.id)
                        } label: {
                            HStack(spacing: 5) {
                                Image(systemName: "plus.circle")
                                Text("New Category")
                            }
                            .font(.subheadline)
                            .tint(.primary)
                            .foregroundStyle(.secondary)
                        }
                    }
                } header: {
                    EditCategoryGroupRow(
                        id: group.id,
                        intent: intent,
                        editedName: bindingFor(categoryGroup: group)
                    )
                }
            }
        }
        .listStyle(.insetGrouped)
        .environment(\.editMode, $editMode)
        .navigationTitle("Edit Categories")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    coordinator.dismiss()
                }
                .fontWeight(.semibold)
            }
        }
        .sheet(item: $coordinator.destination) { destination in
            switch destination {
            case .newGroup:
                NewGroupView(intent: intent)
            case .newCategory(let groupId):
                NewCategoryView(groupId: groupId, intent: intent)
            }
        }
    }
    
    private func bindingFor(category: EditableCategoryPresentation) -> Binding<String> {
        return Binding(
            get: { localValues[category.id, default: category.name] },
            set: { localValues[category.id] = $0 }
        )
    }
    
    private func bindingFor(categoryGroup: EditableCategoryGroupPresentation) -> Binding<String> {
        return Binding(
            get: { localValues[categoryGroup.id, default: categoryGroup.name] },
            set: { localValues[categoryGroup.id] = $0 }
        )
    }
}

#Preview {
    EditCategoriesListView(
        intent: { _ in },
        coordinator: .init(),
        categoryGroups: [EditableCategoryGroupPresentation.obligations, .trueExpenses, .monthlyExpenses, .fun]
    )
}
