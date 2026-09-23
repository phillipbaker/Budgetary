//
//  PayeeNameRow.swift
//  Budgetary
//
//  Created by Phillip Baker on 12/06/2025.
//

import SwiftUI

struct PayeeNameRow: View {
    let payee: PayeePresentation
    let onSelect: (PayeePresentation) -> Void
    
    var body: some View {
        Button {
            onSelect(payee)
        } label: {
            HStack(spacing: 0) {
                if case .transfer = payee.type {
                    Text("To/From: ")
                }
                Text(payee.name)
            }
        }
        .tint(.primary)
    }
}

#Preview {
    PayeeNameRow(
        payee: .init(id: .init(), name: "Sainsbury’s", type: .regular),
        onSelect: { _ in }
    )
    PayeeNameRow(
        payee: .init(id: .init(), name: "Transfer to Savings", type: .transfer(.init())),
        onSelect: { _ in }
    )
}
