//
//  CategoryDetailView.swift
//  Budgetary
//
//  Created by Phillip Baker on 11/09/2024.
//

import SwiftUI

@Observable
final class CategoryDetailModel: Identifiable {
    var category: Category
    
    init(category: Category) {
        self.category = category
    }
    
    func createTargetButtonTapped() {
        // add method to add target on Category entity
    }
    
    func renameCategoryButtonTapped() {
        
    }
    
    func hideCategoryButtonTapped() {
        
    }
    
    func deleteCategoryButtonTapped() {
        
    }
    
    func doneEditingButtonTapped() {
        // Do something
        // Dismiss view
    }
}

struct CategoryDetailView: View {
//    @Bindable var model: CategoryDetailModel
//    let category: CategoryPresentation
    
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
//                            model.createTargetButtonTapped()
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
//                        model.renameCategoryButtonTapped()
                    } label: {
                        Label("Rename Category", systemImage: "square.and.pencil")
                            .symbolVariant(.fill)
                    }
                    
                    Button {
//                        model.hideCategoryButtonTapped()
                    } label: {
                        Label("Hide Category", systemImage: "eye.slash")
                            .symbolVariant(.fill)
                    }
                    
                    Button {
//                        model.deleteCategoryButtonTapped()
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
//                        model.doneEditingButtonTapped()
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
