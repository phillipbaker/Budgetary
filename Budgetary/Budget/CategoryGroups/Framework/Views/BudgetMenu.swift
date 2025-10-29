//
//  BudgetMenu.swift
//  Budgetary
//
//  Created by Phillip Baker on 28/09/2024.
//

import Factory
import SwiftUI

struct BudgetMenu: View {
    @Environment(BudgetCoordinator.self) var coordinator
    
    var body: some View {
        Menu {
            Button {
                coordinator.editCateogoriesButtonTapped()
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
            Image(systemName: "ellipsis")
        }
    }
}

#Preview {
    BudgetMenu()
}
