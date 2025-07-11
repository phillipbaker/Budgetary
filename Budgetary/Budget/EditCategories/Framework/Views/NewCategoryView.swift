//
//  NewCategoryView.swift
//  Budgetary
//
//  Created by Phillip Baker on 13/06/2025.
//

import SwiftUI

struct NewCategoryView: View {
    let groupId: String
    let intent: (EditCategoriesIntent) -> Void
    
    @State private var name: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color(uiColor: .systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                HStack {
                    Text(name)
                    
                    Spacer()
                    
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .font(.title3)
                            .tint(.primary.opacity(0.2))
                            .padding(8)
                    }
                }
                .frame(maxWidth: .infinity)
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.leading)
                
                TextField("New Category Name", text: $name)
                    .padding()
                    .background(.white)
                    .cornerRadius(8)
                    .onSubmit {
                        intent(.newCategory(name: name, groupId: groupId))
                        dismiss()
                    }
                
                Button {
                    intent(.newCategory(name: name, groupId: groupId))
                    dismiss()
                } label: {
                    Text("Save")
                        .padding(.vertical, 4)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .disabled(name.isEmpty)
            }
            .padding()
            .presentationDetents([.medium, .large])
        }
        .font(.subheadline)
    }
}

#Preview {
    @Previewable @State var name: String = "New name"
    NewCategoryView(
        groupId: "",
        intent: { _ in }
    )
}
