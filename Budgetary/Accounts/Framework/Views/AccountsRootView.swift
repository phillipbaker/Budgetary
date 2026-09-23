//
//  AccountsRootView.swift
//  Budgetary
//
//  Created by Phillip Baker on 02/05/2025.
//

import Factory
import SwiftUI

struct AccountsRootView: View {
    let viewModel: AccountsViewModel = Container.shared.accountsViewModel()
    
    var body: some View {
        Group {
            switch viewModel.viewState {
            case .notLoaded:
                EmptyView() // TODO: - Need to figure out notLoaded -> Loading everywhere
            case .loading:
                ProgressView()
            case .error(let error):
                Text(error.localizedDescription)
            case .loaded(let accountsPresentationState):
                AccountsView(
                    state: accountsPresentationState,
                    action: viewModel.handle
                )
            }
        }
        .onAppear {
            viewModel.handle(action: .accountsTabAppeared)
        }
    }
}

#Preview {
    AccountsRootView()
}
