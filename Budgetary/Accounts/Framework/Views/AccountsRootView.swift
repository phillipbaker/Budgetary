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
            switch viewModel.state {
            case .error:
                Text("Accounts Error")
            case .loading:
                ProgressView()
            case .success(let accounts):
                NavigationStack {
                    AccountsListView(accounts: accounts)
                }
            }
        }
        .task {
            viewModel.handle(intent: .getAccounts)
        }
    }
}

#Preview {
    AccountsRootView()
}
