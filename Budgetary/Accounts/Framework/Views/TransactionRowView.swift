//
//  TransactionRowView.swift
//  Budgetary
//
//  Created by Phillip Baker on 02/05/2025.
//

import SwiftUI
import Factory

struct TransactionRowView: View {
    let transaction: TransactionPresentation
    @State var transactionDetailIsPresented: Bool = false
    
    var body: some View {
        Button {
            self.transactionDetailIsPresented = true
        } label: {
            VStack(spacing: 8) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(transaction.payee?.name ?? "")
                            .font(.headline)
                        Text(transaction.category?.name ?? "Category Needed")
                            .font(.subheadline)
                            .foregroundStyle(transaction.category == nil ? .yellow : .secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(alignment: .trailing, spacing: 4){
                        Text(transaction.amount.value)
                            .font(.headline)
                        if !transaction.isCleared {
                            Text("Uncleared")
                                .font(.caption)
                                .padding(4)
                                .background(Color.gray.opacity(0.1))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                }
                
                if !transaction.memo.isEmpty {
                    Text(transaction.memo)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .italic()
                }
            }
        }
        .sheet(isPresented: $transactionDetailIsPresented, onDismiss: { transactionDetailIsPresented = false }) {
            TransactionDetailView(viewModel: Container.shared.transactionDetailViewModel((transaction, false)))
        }
        
    }
}

#Preview {
    TransactionRowView(
        transaction: .init(
            id: "45",
            date: .now,
            memo: "Weekly shop",
            amount: AmountPresentation(transactionType: .outflow, value: "500.00"),
            isCleared: false,
            payee: PayeePresentation(id: "9", name: "Sainsbury’s"),
            category: TransactionCategoryPresentation(id: "11", name: "Groceries"),
            account: TransactionAccountPresentation(id: "1", name: "HSBC - Joint")
        )
    )
}
