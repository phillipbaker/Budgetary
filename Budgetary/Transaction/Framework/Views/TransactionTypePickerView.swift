//
//  TransactionTypePickerView.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/02/2026.
//

import SwiftUI

struct TransactionTypePickerView: View {
    @Binding var transactionType: TransactionTypePresentation
    let transactionTypePickerIsDisabled: Bool
    
    var body: some View {
        Picker("Transaction Type", selection: $transactionType) {
            Text("- Outflow")
                .tag(TransactionTypePresentation.outflow)
            Text("+ Inflow")
                .tag(TransactionTypePresentation.inflow)
        }
        .pickerStyle(.segmented)
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .disabled(transactionTypePickerIsDisabled)
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}

#Preview {
    TransactionTypePickerView(
        transactionType: .constant(.outflow),
        transactionTypePickerIsDisabled: false
    )
}
