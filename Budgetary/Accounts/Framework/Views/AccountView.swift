//
//  TransactionsListView.swift
//  Budgetary
//
//  Created by Phillip Baker on 02/05/2025.
//

import SwiftUI

struct AccountView: View {
    let account: BudgetAccountPresentation
    
    @State private var searchText: String = ""
    @State private var destination: Destination?
    
    enum Destination: String, Identifiable {
        case transactionDetail
        
        var id: String { rawValue }
    }
    
    var body: some View {
        List {
            ForEach(filteredTransactions) { transactionDate in
                Section {
                    ForEach(transactionDate.transactions) { transaction in
                        TransactionRowView(transaction: transaction)
                    }
                } header: {
                    Text(transactionDate.date.formatted(.dateTime.day().month().year()))
                        .textCase(.none)
                        .font(.subheadline)
                }
            }
        }
        .listStyle(.sidebar)
        .navigationTitle(account.name)
        .navigationBarTitleDisplayMode(.inline)
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Search Transactions"
        )
    }
    
    private var filteredTransactions: [TransactionDate] {
        guard !searchText.isEmpty else { return account.transactionsByDate }
        
        var transactionDates: [TransactionDate] = []
        
        for transactionDate in account.transactionsByDate {
            let matchingTransactions = transactionDate.transactions.filter { transaction in
                (transaction.payee?.name.lowercased() ?? "").contains(searchText.lowercased())
            }
            transactionDates.append(
                TransactionDate(id: transactionDate.id, date: transactionDate.date, transactions: matchingTransactions)
            )
        }
        return transactionDates.filter { !$0.transactions.isEmpty }
    }
}

#Preview {
    AccountView(
        account: BudgetAccountPresentation(
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
                            date: .now,
                            memo: "",
                            amount: AmountPresentation(transactionType: .outflow, value: "500.00"),
                            isCleared: true,
                            payee: PayeePresentation(id: "3", name: "Sainsbury’s"),
                            category: TransactionCategoryPresentation(id: "4", name: "Groceries"),
                            account: TransactionAccountPresentation(id: "1", name: "HSBC - Joint")
                        )
                    ]
                )
            ]
        )
    )
}
