//
//  NewTransactionAmountView.swift
//  Budgetary
//
//  Created by Phillip Baker on 18/05/2025.
//

import SwiftUI

struct NewTransactionAmountView: View {
    @Binding var amount: String
    @Binding var transactionType: TransactionType
    @FocusState var focusedField: NewTransactionView.FocusedField?

    @Binding var localValues: Operands
    
    let currencyCode: String = "GBP"
    
    var body: some View {
        HStack(spacing: 0) {
            CurrencyTextField(
                text: $localValues.primary,
                currencyCode: currencyCode,
                onEquals: {},
                onSubmit: { onSubmit() },
                onCancel: {},
                onOperation: { operation in handle(operation: operation) },
                onTextChanged: { newValue in onTextChanged(primaryOperand: newValue) },
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
                        onEquals: { onEquals() },
                        onSubmit: { onSubmit() },
                        onCancel: {},
                        onOperation: { operation in handle(operation: operation) },
                        onTextChanged: { newValue in onTextChanged(secondaryOperand: newValue) },
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
    
    private func onEquals() {
        focusedField = .primaryOperand
        
        DispatchQueue.main.async {
            applyOperation()
        }
    }
    
    private func onSubmit() {
        focusedField = nil
        // If there are primary and secondary values, apply operation (this should fire on secondary text field only)
        if !self.localValues.operation.isEmpty {
            applyOperation()
        }
    }
    
    private func handle(operation: String) {
        if focusedField != .secondaryOperand { focusedField = .secondaryOperand }
        if !self.localValues.operation.isEmpty { applyOperation() } // If an operation in progress, commit the operation
        self.localValues.operation = operation // Set the operation for the next entry
    }
    
    private func applyOperation() {
        // Get Decimal values from Strings to perform operation
        let primary = localValues.primary.decimalValue
        let secondary = localValues.secondary.decimalValue
        
        // Perform operation on Decimal values
        let newTotal = self.localValues.operation == "+" ? primary + secondary : primary - secondary
        
        self.localValues.primary = newTotal.formatted(.currency(code: currencyCode)) // Update to be result of operation
        self.localValues.secondary = Decimal(0.00).formatted(.currency(code: currencyCode)) // Reset for new input
        self.localValues.operation = "" // Reset for new input
    }
    
    private func onTextChanged(primaryOperand: String? = nil, secondaryOperand: String? = nil, operation: String? = nil) {
        if let primaryOperand, primaryOperand != self.localValues.primary {
            self.localValues.primary = primaryOperand
        }
        
        if let secondaryOperand, secondaryOperand != self.localValues.secondary {
            self.localValues.secondary = secondaryOperand
        }
        
        if let operation, operation != self.localValues.operation {
            self.localValues.operation = operation
        }
    }
}

#Preview {
    NewTransactionAmountView(
        amount: .constant(""),
        transactionType: .constant(.outflow),
        localValues: .constant(.init(primary: "", secondary: "", operation: ""))
    )
}
