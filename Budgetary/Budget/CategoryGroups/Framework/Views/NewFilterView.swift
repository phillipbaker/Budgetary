//
//  NewFilterView.swift
//  Budgetary
//
//  Created by Phillip Baker on 03/10/2024.
//

import SwiftUI

struct NewFilterView: View {
//    @Bindable var model: NewFilterModel
//    @State var selection: Set<CategoryPresentation> = []
    
    var body: some View {
        Text("New Filter View")
//        List(selection: $selection) {
//            Section {
//                Text("Choose a set of categories to include in this filter.")
//                    .font(.subheadline)
//                    .foregroundStyle(.secondary)
//            }
//            Section {
//                TextField("Filter Name", text: $model.name)
//            }
//            ForEach($model.categoryGroups) { $group in
//                Section {
//                    ForEach($group.categories) { $category in
//                        Text(category.name)
//                    }
//                } header: {
//                    Text(group.name)
//                }
//            }
//        }
    }
}

#Preview {
    NewFilterView()
}
