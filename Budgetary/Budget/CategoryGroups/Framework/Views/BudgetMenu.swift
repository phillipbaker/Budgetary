//
//  BudgetMenu.swift
//  Budgetary
//
//  Created by Phillip Baker on 28/09/2024.
//

import SwiftUI

struct BudgetMenu: View {
    var destination: (BudgetViewModel.Destination) -> Void
    
    var body: some View {
        Menu {
            Button {
                destination(.editCategories)
            } label: {
                Label("Edit Categories", systemImage: "pencil")
            }
            
            Divider()
            
            Button {
                // suport destination
            } label: {
                Label("Support", systemImage: "questionmark.bubble")
            }
            
            Button {
                // settings destination
            } label: {
                Label("Settings", systemImage: "gear")
            }
        } label: {
            Image(systemName: "ellipsis.circle")
        }
    }
}

#Preview {
    BudgetMenu(destination: { _ in })
}
