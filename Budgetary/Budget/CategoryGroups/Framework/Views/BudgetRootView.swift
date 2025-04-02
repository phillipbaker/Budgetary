//
//  BudgetRootView.swift
//  Budgetary
//
//  Created by Phillip Baker on 29/03/2025.
//

import Factory
import SwiftUI
import SwiftUINavigation

struct BudgetRootView: View {
    @State var viewModel = BudgetViewModel()
    let coordinator: BudgetCoordinator = Container.shared.budgetCoordinator() // @State or just a let? Both seem to work
    
    // TODO: Figure out how to move this somehwere better
    init() {
        viewModel.handle(intent: .getBudget(monthYear: .currentMonthYear, filterId: CategoryFilter.allCategories.id))
    }
    
    var body: some View {
        switch viewModel.state {
        case .loading:
            ProgressView()
        case .error:
            Text("Put Error View Here")
        case .success(let budget):
            NavigationStack {
                BudgetView(
                    coordinator: coordinator,
                    budget: budget,
                    intent: { intent in viewModel.handle(intent: intent) }
                )
                .environment(coordinator)
            }
        }
    }
}
