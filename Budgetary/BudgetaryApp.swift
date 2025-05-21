//
//  BudgetaryApp.swift
//  Budgetary
//
//  Created by Phillip Baker on 07/08/2024.
//

import SwiftData
import SwiftUI

@main
struct BudgetaryApp: App {
    let viewModel = HomeViewModel(selectedTab: .budget, isPresentingTransactionSheet: true)
    
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: viewModel)
        }
    }
}
