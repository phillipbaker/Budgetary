//
//  HomeView.swift
//  Budgetary
//
//  Created by Phillip Baker on 07/08/2024.
//

import SwiftUI

struct HomeView: View {
    @Bindable var viewModel: HomeViewModel
    
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
        NavigationStack() {
            content()
        }
    }
}
