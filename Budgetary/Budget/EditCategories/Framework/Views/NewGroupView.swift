//
//  NewItemView.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/04/2025.
//

import SwiftUI

struct NewGroupView: View {
    let action: (EditCategoriesAction) -> Void
    @Environment(EditCategoriesCoordinator.self) var coordinator
    
    @State private var name: String = ""
    
    var body: some View {
        ZStack {
            Color(uiColor: .systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                HStack {
                    Text(name)
                    
                    Spacer()
                    
                    Button {
                        coordinator.dismiss()
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
                
                TextField("New Group Name", text: $name)
                    .padding()
                    .background(.white)
                    .cornerRadius(8)
                    .onSubmit {
                        action(.newGroup(name: name))
                        coordinator.dismiss()
                    }
                
                Button {
                    action(.newGroup(name: name))
                    coordinator.dismiss()
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
