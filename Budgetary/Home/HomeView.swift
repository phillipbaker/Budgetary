//
//  HomeView.swift
//  Budgetary
//
//  Created by Phillip Baker on 07/08/2024.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Bindable var viewModel: HomeViewModel
    
    @State private var paths: [AppTab: NavigationPath] = [
        .budget: NavigationPath(),
        .accounts: NavigationPath()
    ]
    
    var body: some View {
        TabView(selection: $viewModel.viewState.selectedTab) {
            Tab("Budget", systemImage: "banknote", value: .budget) {
                tabView(.budget) {
                    BudgetRootView()
                }
            }
            .customizationBehavior(.disabled, for: .sidebar, .tabBar)
            
            Tab("Accounts", systemImage: "building.columns.fill", value: .accounts) {
                tabView(.accounts) {
                    AccountsRootView()
                }
            }
        }
        .tabViewStyle(.sidebarAdaptable)
        .tabViewBottomAccessory {
            Button {
                viewModel.handle(action: .newTransactionButtonTapped(viewModel.viewState.selectedTab))
            } label: {
                HStack {
                    Image(systemName: "plus")
                    Text("Transaction")
                }
                .frame(maxWidth: .infinity)
                .contentShape(.capsule)
            }
        }
        .sheet(
            item: $viewModel.viewState.sheet,
            onDismiss: { viewModel.handle(action: .sheetDismissed) }
        ) { sheet in
            SheetView(sheet: sheet)
        }
        .onChange(of: viewModel.viewState.selectedTab) { _, newValue in
            viewModel.handle(action: .tabSelected(newValue))
        }
    }
    
    @ViewBuilder
    private func tabView<Content: View>(
        _ tab: AppTab,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationStack(path: pathBinding(for: tab)) {
            content()
                .navigationDestination(for: Destination.self) { destination in
                    destinationView(destination)
                }
        }
        .tag(tab)
    }
    
    private func pathBinding(for tab: AppTab) -> Binding<NavigationPath> {
        Binding(
            get: {
                NavigationPath(viewModel.viewState.tabDestinations[tab] ?? [])
            },
            set: { newPath in
                let newCount = newPath.count
                let oldCount = viewModel.viewState.tabDestinations[tab]?.count ?? 0

                if newCount < oldCount {
                    viewModel.handle(action: .pop(tab))
                }
            }
        )
    }
    
    @ViewBuilder
    func destinationView(_ destination: Destination) -> some View {
//        switch destination {
//        }
    }

}

//            if horizontalSizeClass == .regular {
//                TabSection("Budget Accounts") {
//                    Tab("HSBC - Joint", systemImage: "building.columns.fill", value: AppTab.hsbcJoint) {
//                        Text("HSBC Joint Account View")
//                    }
//                }
//                .defaultVisibility(.hidden, for: .tabBar)
//
//                TabSection("Loans") {
//                    Tab("Discover Student Loan", systemImage: "building.columns.fill", value: AppTab.discover) {
//                        Text("Discover Student Loan")
//                    }
//                }
//                .defaultVisibility(.hidden, for: .tabBar)
//
//                TabSection("Tracking Accounts") {
//                    Tab("NY 529", systemImage: "building.columns.fill", value: AppTab.ny529) {
//                        Text("NY 529")
//                    }
//                }
//                .defaultVisibility(.hidden, for: .tabBar)
//            }

//            Tab("Search", systemImage: "magnifyingglass", value: .search, role: .search) {
//                Color.clear
//            }

