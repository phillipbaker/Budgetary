//
//  TransactionRowView.swift
//  Budgetary
//
//  Created by Phillip Baker on 02/05/2025.
//

import SwiftUI

struct TransactionRowView: View {
    let transaction: TransactionPresentation
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(transaction.payee?.name ?? "")
                        .font(.headline)
                    Text(transaction.category?.name ?? "No category")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
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
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
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
}

#Preview {
    TransactionRowView(
        transaction: .init(
            id: "45",
            date: "02/05/2025",
            payee: PayeePresentation(id: "9", name: "Sainsbury’s"),
            category: TransactionCategoryPresentation(id: "11", name: "Groceries"),
            memo: "Weekly shop",
            amount: .outflow("500.00"),
            isCleared: false
        )
    )
}
