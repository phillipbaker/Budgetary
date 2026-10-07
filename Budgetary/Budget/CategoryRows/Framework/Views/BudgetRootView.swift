//
//  BudgetRootView.swift
//  Budgetary
//
//  Created by Phillip Baker on 29/03/2025.
//

import Factory
import SwiftUI

struct BudgetRootView: View {
    @Bindable var viewModel: BudgetViewModel = Container.shared.budgetViewModel()
    
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
                    destination: $viewModel.destination
                )
            }
        }
        .onAppear {
            viewModel.handle(action: .budgetTabAppeared)
        }
    }
}
