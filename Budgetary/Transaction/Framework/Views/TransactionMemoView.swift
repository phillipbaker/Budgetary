//
//  TransactionMemoView.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/02/2026.
//

import SwiftUI

struct TransactionMemoView: View {
    @Binding var memo: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "note.text")
                .frame(width: 32, height: 32)
                .symbolVariant(memo.isEmpty ? .none : .fill)
                .foregroundStyle(memo.isEmpty ? .secondary : Color.accentColor)
            TextField("Enter a memo...", text: $memo)
        }
        .frame(minHeight: 40)
    }
}

#Preview {
    TransactionMemoView(memo: .constant(""))
}
