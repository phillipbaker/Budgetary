//
//  AccountsListView.swift
//  Budgetary
//
//  Created by Phillip Baker on 02/05/2025.
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

#Preview {
    AccountsListView(
        accounts: [
            BudgetAccountPresentation(
                id: "1",
                name: "HSBC Joint",
                startingBalance: "£0.00",
                notes: "",
                isClosed: false,
                balance: "£1,250.00",
                transactionsByDate: [
                    TransactionDate(
                        id: UUID().uuidString,
                        date: .now,
                        transactions: [
                            .init(
                                id: "2",
                                date: "2/5/2025",
                                payee: PayeePresentation(id: "3", name: "Sainsbury’s"),
                                category: TransactionCategoryPresentation(id: "4", name: "Groceries"),
                                memo: "",
                                amount: .outflow("500.00"),
                                isCleared: true
                            )
                        ]
                    )
                ]
            )
        ]
    )
}
