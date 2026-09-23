//
//  BudgetaryApp.swift
//  Budgetary
//
//  Created by Phillip Baker on 07/08/2024.
//

import Factory
import SwiftData
import SwiftUI

@main
struct BudgetaryApp: App {
    let viewModel: HomeViewModel = Container.shared.homeViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: viewModel)
        }
    }
}
