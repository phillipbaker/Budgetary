//
//  CategoryDetailView.swift
//  Budgetary
//
//  Created by Phillip Baker on 11/09/2024.
//

import SwiftUI

struct CategoryDetailView: View {    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack(spacing: 16) {
                        Text("How much do you need for [insery name here]?")
                            .font(.headline)
                        
                        Text("When you create target, we’ll let you know how much money to set aside to stay on track over time.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                        Button {

                        } label: {
                            Text("Create Target")
                                .font(.headline)
                                .padding(.vertical, 4)
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                } header: {
                    Text("Target")
                        .textCase(.none)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                Section {
                    Text("name")
                } header: {
                    Text("Notes")
                        .textCase(.none)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                
                Section {
                    Button {

                    } label: {
                        Label("Rename Category", systemImage: "square.and.pencil")
                            .symbolVariant(.fill)
                    }
                    
                    Button {

                    } label: {
                        Label("Hide Category", systemImage: "eye.slash")
                            .symbolVariant(.fill)
                    }
                    
                    Button {

                    } label: {
                        Label("Delete Category", systemImage: "trash")
                            .symbolVariant(.fill)
                    }
                }
            }
            .navigationTitle("name")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {

                    } label: {
                        Text("Done")
                            .fontWeight(.semibold)
                    }
                }
            }
        }
    }
}

#Preview {
    CategoryDetailView()
}
