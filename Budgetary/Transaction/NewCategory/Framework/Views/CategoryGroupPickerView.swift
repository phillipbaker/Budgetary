//
//  CategoryGroupPickerView.swift
//  Budgetary
//
//  Created by Phillip Baker on 18/03/2026.
//

import SwiftUI

struct CategoryGroupPickerView: View {
    @Bindable var model: CategoryGroupPickerViewModel
    
    var body: some View {
        List {
            Section {
                AddItemButton("New Category Group") {
                    model.newGroupButtonTapped()
                }
            }
            Section {
                ForEach(model.categoryGroups) { group in
                    HStack {
                        Image(systemName: "checkmark")
                            .foregroundStyle(.tint)
                            .opacity(group == model.selectedGroup ? 1 : 0)
                        Button(group.name) {
                            model.selectGroupButtonTapped(group)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .tint(.primary)
                    }
                }
            }
        }
        .contentMargins(.top, 12)
        .navigationTitle("Category Group")
        .sheet(isPresented: $model.newCategoryGroupSheetIsPresented) {
            NavigationStack {
                NewCategoryGroupView(
                    onGroupCreated: model.onGroupCreated,
                    onCancel: model.onCancel
                )
            }
        }
    }
}
