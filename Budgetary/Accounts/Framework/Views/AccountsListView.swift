//
//  AccountsListView.swift
//  Budgetary
//
//  Created by Phillip Baker on 23/05/2025.
//

import SwiftUI

struct AccountsListView: View {
    let accounts: [BudgetAccountPresentation]
    
    var body: some View {
        List {
            Section {
                Text("All Transactions")
            }
            
            Section {
                ForEach(accounts) { account in
                    NavigationLink(value: account) {
                        HStack {
                            Text(account.name)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(account.balance)
                        }
                    }
                }
            } header: {
                Text("Budget Accounts")
            }
            
            Section {
                Button {
                    
                } label: {
                    Text("Add Account")
                }
            }
        }
        .navigationTitle("Accounts")
        .navigationDestination(for: BudgetAccountPresentation.self) { account in
            AccountView(account: account)
        }
    }
}
