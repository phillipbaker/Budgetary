//
//  HomeView.swift
//  Budgetary
//
//  Created by Phillip Baker on 07/08/2024.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @State var budgetViewModel = BudgetViewModel(
        stateMapper: BudgetStateMapper(mapper: BudgetPresentationMapper()),
        getBudgetUseCase: GetBudget(
            source: GetBudgetSourceCombined(
                budgetDataSourceLocal: BudgetLocalDatagateway(
                    dao: BudgetDao(
                        container: try! ModelContainer(),
                        mapper: BudgetMapperPlain()
                    ),
                    mapper: BudgetMapperPlain()
                ),
                payeesDataSourceLocal: PayeesLocalDataGateway(
                    dao: PayeeDao(container: try! ModelContainer()),
                    mapper: PayeesMapperPlain()
                ),
                budgetAccountsDataSourceLocal: BudgetAccountsLocalDataGateway(
                    dao: BudgetAccountDao(container: try! ModelContainer()),
                    mapper: BudgetAccountsMapperPlain()
                ),
                categoryGroupsDataSourceLocal: CategoryGroupsLocalDataGateway(
                    dao: CategoryGroupDao(container: try! ModelContainer()),
                    mapper: CategoryGroupsMapperPlain()
                ),
                mapper: CombinedBudgetDataMapper()
            ),
            mapper: BudgetMapper()
        )
    )
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
