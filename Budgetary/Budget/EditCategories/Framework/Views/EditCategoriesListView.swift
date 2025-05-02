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
    var categoryGroups: [EditableCategoryGroupPresentation]
    let intent: (EditCategoriesIntent) -> Void
    
    @State private var showNewCategorySheet = false
    @State private var showNewGroupSheet = false
    @State private var localValues: [String: String] = [:]
    
    @Environment(BudgetCoordinator.self) var coordinator
    @State private var editMode: EditMode = .inactive
    
    @State private var draggedCategoryId: String?
    
    var body: some View {
        @Bindable var coordinator = coordinator
        
        List {
            HStack(spacing: 16) {
                Button {
                    showNewGroupSheet = true
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
                    .dropDestination(for: EditableCategoryPresentation.self) { droppedCategories, index in
                        move(droppedCategories: droppedCategories, to: group.id, at: index)
                    }
                    
                    if editMode == .inactive {
                        Button {
                            showNewCategorySheet = true
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
                .sheet(isPresented: $showNewGroupSheet, onDismiss: { showNewGroupSheet = false} ) {
                    NewGroupView(intent: intent)
                }
                .sheet(isPresented: $showNewCategorySheet, onDismiss: { showNewCategorySheet = false }) {
                    NewCategoryView(groupId: group.id, intent: intent)
                }
            }
//            .onMove { offsets, newOffset in
//                intent(.moveCategoryGroup(from: offsets, to: newOffset))
//            }
        }
        .listStyle(.insetGrouped)
        .environment(\.editMode, $editMode)
        .navigationTitle("Edit Categories")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    coordinator.doneEditingCategoriesButtonTapped()
                }
                .fontWeight(.semibold)
            }
        }
    }
    
    private func move(droppedCategories: [EditableCategoryPresentation], to destinationGroupId: String, at index: Int) {
        guard let dropped = droppedCategories.first else { return }
        intent(.moveCategory(id: dropped.id, toDestinationGroupId: destinationGroupId, atIndex: index))
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
        categoryGroups: [EditableCategoryGroupPresentation.obligations, .trueExpenses, .monthlyExpenses, .fun],
        intent: { _ in }
    )
}
