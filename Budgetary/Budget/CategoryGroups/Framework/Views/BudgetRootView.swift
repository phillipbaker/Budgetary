//
//  BudgetRootView.swift
//  Budgetary
//
//  Created by Phillip Baker on 29/03/2025.
//

import Factory
import SwiftUI

struct BudgetRootView: View {
    let viewModel: BudgetViewModel = Container.shared.budgetViewModel()
    let coordinator: BudgetCoordinator = Container.shared.budgetCoordinator()
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .error:
                Text("Put Error View Here")
            case .success(let budget):
                    BudgetView(
                        budget: budget,
                        intent: { intent in viewModel.handle(intent: intent) },
                        coordinator: coordinator
                    )
                    .environment(coordinator)
            }
        }
        .task {
            viewModel.handle(intent: .getBudget(monthYear: .currentMonthYear, filterId: CategoryFilter.allCategories.id))
        }
    }
}
