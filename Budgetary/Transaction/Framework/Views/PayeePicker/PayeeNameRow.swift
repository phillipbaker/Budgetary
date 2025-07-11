//
//  PayeeNameRow.swift
//  Budgetary
//
//  Created by Phillip Baker on 12/06/2025.
//

import SwiftUI

struct PayeeNameRow: View {
    let action: (PayeePresentation) -> Void
    let payee: PayeePresentation
    
    var body: some View {
        Button {
            action(payee)
        } label: {
            Text(payee.name)
        }
        .tint(.primary)
    }
}

#Preview {
    PayeeNameRow(
        action: { _ in },
        payee: .init(id: "", name: "Sainsbury’s")
    )
}
