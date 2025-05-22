//
//  NewTransactionAmountView.swift
//  Budgetary
//
//  Created by Phillip Baker on 18/05/2025.
//

import SwiftUI

struct NewTransactionAmountView: View {
    @Binding var localValues: Operands
    let currencyCode: String
    @Binding var transactionType: TransactionType
    @FocusState var focusedField: NewTransactionViewModel.FocusedField?
    
    let onEquals: () -> Void
    let onSubmit: () -> Void
    let onOperation: (String) -> Void
    let onPrimaryOperandTextChanged: (String) -> Void
    let onSecondaryOperandTextChanged: (String) -> Void

    var body: some View {
        HStack(spacing: 0) {
            CurrencyTextField(
                text: $localValues.primary,
                currencyCode: currencyCode,
                onEquals: {},
                onSubmit: onSubmit,
                onCancel: {},
                onOperation: onOperation,
                onTextChanged: onPrimaryOperandTextChanged,
                textColor: UIColor(transactionType == .outflow ? .red : .green),
                textStyle: .largeTitle,
                fontWeight: .semibold,
                textAlignment: .center,
                isShowingCancel: false,
                isShowingNavigationRow: false,
                destination: { _ in }
            )
            .focused($focusedField, equals: .primaryOperand)
            
            if !self.localValues.operation.isEmpty {
                HStack(spacing: 0) {
                    Text(localValues.operation)
                        .font(.largeTitle)
                        .foregroundStyle(transactionType == .outflow ? .red : .green)
                        .fontWeight(.semibold)
                    CurrencyTextField(
                        text: $localValues.secondary,
                        currencyCode: currencyCode,
                        onEquals: onEquals,
                        onSubmit: onSubmit,
                        onCancel: {},
                        onOperation: onOperation,
                        onTextChanged: onSecondaryOperandTextChanged,
                        textColor: UIColor(transactionType == .outflow ? .red : .green),
                        textStyle: .largeTitle,
                        fontWeight: .semibold,
                        textAlignment: .center,
                        isShowingCancel: false,
                        isShowingNavigationRow: false,
                        destination: { _ in }
                    )
                    .focused($focusedField, equals: .secondaryOperand)
                }
            }
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .onAppear {
            if self.transactionType == .outflow, !self.localValues.primary.hasPrefix("-") {
                self.localValues.primary.insert("-", at: self.localValues.primary.startIndex)
            }
        }
    }
}

#Preview {
    NewTransactionAmountView(
        localValues: .constant(.init(primary: "", secondary: "", operation: "")),
        currencyCode: "GBP",
        transactionType: .constant(.outflow),
        onEquals: {},
        onSubmit: {},
        onOperation: { _ in },
        onPrimaryOperandTextChanged: { _ in },
        onSecondaryOperandTextChanged: { _ in }
    )
}
