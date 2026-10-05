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
    let coordinator: AppCoordinator = Container.shared.appCoordinator()
    
    var body: some View {
        Group {
            switch viewModel.viewState {
            case .notLoaded:
                Color.clear
            case .loading:
                ProgressView()
            case .error(let error):
                Text(error.localizedDescription)
            case .budget(let budgetPresentationState):
                BudgetView(
                    action: viewModel.handle,
                    state: budgetPresentationState,
                    coordinator: coordinator
                )
                .environment(coordinator)
            }
        }
        .onAppear {
            viewModel.handle(action: .budgetTabAppeared)
        }
    }
}
