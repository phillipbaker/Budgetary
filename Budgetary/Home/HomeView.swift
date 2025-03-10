//
//  HomeView.swift
//  Budgetary
//
//  Created by Phillip Baker on 07/08/2024.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @State var budgetViewModel: BudgetViewModel
    @Bindable var model: HomeViewModel
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        TabView {
            Tab("Budget", systemImage: "banknote") {
                BudgetRootView(viewModel: budgetViewModel)
            }
            .customizationBehavior(.disabled, for: .sidebar, .tabBar)
            
            Tab("Accounts", systemImage: "building.columns.fill") {
                Text("All Acccounts View")
            }
            
            if horizontalSizeClass == .regular {
                TabSection("Budget Accounts") {
                    Tab("HSBC - Joint", systemImage: "building.columns.fill") {
                        Text("HSBC Joint Account View")
                    }
                }
                .defaultVisibility(.hidden, for: .tabBar)
                
                TabSection("Loans") {
                    Tab("Discover Student Loan", systemImage: "building.columns.fill") {
                        Text("Discover Student Loan")
                    }
                }
                .defaultVisibility(.hidden, for: .tabBar)
                
                TabSection("Tracking Accounts") {
                    Tab("NY 529", systemImage: "building.columns.fill") {
                        Text("NY 529")
                    }
                }
                .defaultVisibility(.hidden, for: .tabBar)
            }
        }
        .tabViewStyle(.sidebarAdaptable)
    }
}

//#Preview {
//    HomeView(model: .init())
//}
