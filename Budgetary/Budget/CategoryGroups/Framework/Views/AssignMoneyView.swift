//
//  AssignMoneyView.swift
//  Budgetary
//
//  Created by Phillip Baker on 28/01/2025.
//

import SwiftUI

struct AssignMoneyView: View {
    @Binding var rowID: UUID
    let monthYear: MonthYear
    let category: CategoryPresentation
    let currencyCode: String
    let intent: (BudgetIntent) -> Void
    
    @Binding var localValue: AssignedValue
    @FocusState var focus: CategoryRowView.FocusedField?
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            CurrencyTextField(
                text: $localValue.primary,
                currencyCode: currencyCode,
                focus: _focus,
                onEquals: {},
                onSubmit: { onSubmit() },
                onCancel: { onCancel() },
                onOperation: { operation in handle(operation: operation) },
                onTextChanged: { newValue in updateAssignedAmountLocal(primary: newValue) }
            )
            .focused($focus, equals: .primary(id: rowID))
            
            if !localValue.operation.isEmpty {
                HStack(spacing: 2) {
                    Text(localValue.operation)
                    CurrencyTextField(
                        text: $localValue.secondary,
                        currencyCode: currencyCode,
                        focus: _focus,
                        onEquals: { onEquals() },
                        onSubmit: { onSubmit() },
                        onCancel: { onCancel() },
                        onOperation: { operation in handle(operation: operation) },
                        onTextChanged: { newValue in updateAssignedAmountLocal(secondary: newValue) }
                    )
                    .focused($focus, equals: .secondary(id: rowID))
                }
            }
        }
        .offset(x: -4)
        .onChange(of: focus) { oldValue, newValue in
            guard oldValue == .primary(id: rowID) || oldValue == .secondary(id: rowID) else { return }
            // If focus changes to a new row, apply in progress opperation if there is one, commit the new value
            if newValue != .primary(id: rowID) && newValue != .secondary(id: rowID) {
                onSubmit()
            }
        }
    }
    
    private func updateAssignedAmountLocal(primary: String? = nil, secondary: String? = nil, operation: String? = nil) {
        localValue.primary = primary ?? localValue.primary
        localValue.secondary = secondary ?? localValue.secondary
        localValue.operation = operation ?? localValue.operation
    }
    
    private func onEquals() {
        focus = .primary(id: rowID)
        
        DispatchQueue.main.async {
            applyOperation()
        }
    }
    
    private func onSubmit() {
        focus = nil
        // If there are primary and secondary values, apply operation (this should fire on secondary text field only)
        if !localValue.operation.isEmpty {
            applyOperation()
        }
        intent(.updateAssignedAmount(categoryId: category.id, monthYear: monthYear, amount: localValue.primary))
        localValue.lastCommitted = localValue.primary // Update lastComitted to the new primary value
    }
    
    private func onCancel() {
        focus = nil
        let lastCommittedDecimal = localValue.lastCommitted.decimalValue
        localValue.primary = lastCommittedDecimal.formatted(.currency(code: currencyCode))
        if localValue.operation != "" { localValue.operation = "" }
        localValue.secondary = Decimal(0.00).formatted(.currency(code: currencyCode))
    }
    
    private func handle(operation: String) {
        if focus != .secondary(id: rowID) { focus = .secondary(id: rowID) }
        if !localValue.operation.isEmpty { applyOperation() } // If an operation in progress, commit the operation
        localValue.operation = operation // Set the operation for the next entry
    }
    
    private func applyOperation() {
        // Get Decimal values from Strings to perform operation
        let primary = localValue.primary.decimalValue
        let secondary = localValue.secondary.decimalValue
        
        // Perform operation on Decimal values
        let newTotal = localValue.operation == "+" ? primary + secondary : primary - secondary
        
        localValue.primary = newTotal.formatted(.currency(code: currencyCode)) // Update to be result of operation
        localValue.secondary = Decimal(0.00).formatted(.currency(code: currencyCode)) // Reset for new input
        localValue.operation = "" // Reset for new input
    }
}

#Preview {
    @Previewable @State var assignedLocalValue = AssignedValue(
        primary: "9.99",
        secondary: "0.00",
        operation: "",
        lastCommitted: "0.00"
    )
    
    AssignMoneyView(
        rowID: .constant(UUID()),
        monthYear: .currentMonthYear,
        category: .amazonPrime,
        currencyCode: "GBP",
        intent: { _ in },
        localValue: $assignedLocalValue
    )
}
