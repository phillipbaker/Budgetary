//
//  NewCategoryInGroupView.swift
//  Budgetary
//
//  Created by Phillip Baker on 13/06/2025.
//

import SwiftUI

struct NewCategoryInGroupView: View {
    @State private var groupId: String? = nil
    @State var name: String = ""
    @State private var groupPickerIsPresented: Bool = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color(uiColor: .systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                VStack(alignment: .leading) {
                    if !name.isEmpty {
                        Text("Category Name")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    TextField("New Category Name", text: $name)
                        .onSubmit {
    //                        intent(.newCategory(name: name, groupId: groupId))
                            dismiss()
                        }
                }
                .padding()
                .background(.white)
                .cornerRadius(10)
                
                Button {
                    groupPickerIsPresented = true
                } label: {
                    Text("Choose Category Group...")
                        .padding(.leading)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding()
            .presentationDetents([.medium, .large])
        }
        .font(.subheadline)
        .navigationTitle("New Category")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $groupPickerIsPresented) {
            Text("Group Picker")
        }
    }
}

#Preview {
    NewCategoryInGroupView()
}
