//
//  HomeView.swift
//  Budgetary
//
//  Created by Phillip Baker on 07/08/2024.
//

import Factory
import Foundation
import SwiftUI
import SwiftData

enum HomeIntent {
    case addTransaction
}

@Observable
final class HomeViewModel {
    var selectedTab: AppTab {
        didSet {
            if selectedTab == .newTransaction {
                self.newTransactionSheetIsPresented = true
                self.selectedTab = oldValue
            }
        }
    }

    var newTransactionSheetIsPresented: Bool
    
    enum AppTab: Hashable {
        case budget
        case accounts
        case newTransaction
        case hsbcJoint
        case discover
        case ny529
    }

    init(
        selectedTab: AppTab = .budget,
        isPresentingTransactionSheet: Bool = false
    ) {
        self.selectedTab = selectedTab
        self.newTransactionSheetIsPresented = isPresentingTransactionSheet
    }
}

struct HomeView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Bindable var viewModel: HomeViewModel
    
    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            Tab("Budget", systemImage: "banknote", value: .budget) {
                NavigationStack {
                    BudgetRootView()
                }
            }
            .customizationBehavior(.disabled, for: .sidebar, .tabBar)
            
            Tab("Accounts", systemImage: "building.columns.fill", value: .accounts) {
                AccountsRootView()
            }
            
            if horizontalSizeClass == .regular {
                TabSection("Budget Accounts") {
                    Tab("HSBC - Joint", systemImage: "building.columns.fill", value: HomeViewModel.AppTab.hsbcJoint) {
                        Text("HSBC Joint Account View")
                    }
                }
                .defaultVisibility(.hidden, for: .tabBar)
                
                TabSection("Loans") {
                    Tab("Discover Student Loan", systemImage: "building.columns.fill", value: HomeViewModel.AppTab.discover) {
                        Text("Discover Student Loan")
                    }
                }
                .defaultVisibility(.hidden, for: .tabBar)
                
                TabSection("Tracking Accounts") {
                    Tab("NY 529", systemImage: "building.columns.fill", value: HomeViewModel.AppTab.ny529) {
                        Text("NY 529")
                    }
                }
                .defaultVisibility(.hidden, for: .tabBar)
            }
            
            if horizontalSizeClass == .compact {
                Tab("Transaction", systemImage: "plus.circle.fill", value: .newTransaction) {
                    Color.clear
                }
            }
        }
        .tabViewStyle(.sidebarAdaptable)
        .sheet(isPresented: $viewModel.newTransactionSheetIsPresented) {
            TransactionDetailView(viewModel: Container.shared.transactionDetailViewModel((nil, true)))
        }
    }
}
