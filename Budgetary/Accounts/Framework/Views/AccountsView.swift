//
//  AccountsView.swift
//  Budgetary
//
//  Created by Phillip Baker on 23/05/2025.
//

import Factory
import SwiftUI

struct AccountsView: View {
    let state: AccountsPresentationState
    let action: (AccountsAction) -> Void
    
    let addAccountViewModel: AddAccountViewModel = Container.shared.addAccountViewModel()

    var body: some View {
        List {            
            ForEach(BudgetAccountGroupPresentation.allCases) { accountType in
                if let accountsForType = state.accounts[accountType] {
                    Section {
                        ForEach(accountsForType) { account in
                            NavigationLink(value: account) {
                                HStack {
                                    HStack {
                                        Image(systemName: image(for: account.accountType))
                                        Text(account.name)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Text(account.balance)
                                }
                            }
                        }
                    } header: {
                        Text(accountType.rawValue.capitalized)
                    }
                }
            }
            
            Section {
                Button {
                    action(.addAccountButtonTapped)
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "plus.circle")
                        Text("Add Account")
                    }
                }
            }
        }
        .navigationTitle("Accounts")
        .navigationDestination(for: BudgetAccountPresentation.self) { account in
            AccountView(account: account)
        }
    }
    
    private func image(for accountType: BudgetAccountTypePresentation) -> String {
        switch accountType {
        case .cash(.cash):
            return "banknote"
        case .cash(.checking), .cash(.savings):
            return "building.columns"
        case .credit(.creditCard):
            return "creditcard"
        }
    }
}
