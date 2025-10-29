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
    
    @Binding var localValues: AssignedValues
    @FocusState var focusedField: CategoryRowView.FocusedField?
    
    @State var destination: Destination?
    
    enum Destination: String, Identifiable {
        case moveMoney
        case detail
        
        var id: String { rawValue }
    }
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            CurrencyTextField(
                text: $localValues.primary,
                currencyCode: currencyCode,
                onEquals: {},
                onSubmit: { onSubmit() },
                onCancel: { onCancel() },
                onOperation: { operation in handle(operation: operation) },
                onTextChanged: { newValue in updateAssignedAmountLocal(primary: newValue) },
                textColor: UIColor(Color.primary),
                textStyle: .subheadline,
                fontWeight: .semibold,
                textAlignment: .right,
                cancelButtonIsPresented: true,
                navigationRowIsPresented: true,
                destination: { destination in self.destination = destination }
            )
            .focused($focusedField, equals: .primary(id: rowID))
            
            if !localValues.operation.isEmpty {
                HStack(spacing: 2) {
                    Text(localValues.operation)
                    CurrencyTextField(
                        text: $localValues.secondary,
                        currencyCode: currencyCode,
                        onEquals: { onEquals() },
                        onSubmit: { onSubmit() },
                        onCancel: { onCancel() },
                        onOperation: { operation in handle(operation: operation) },
                        onTextChanged: { newValue in updateAssignedAmountLocal(secondary: newValue) },
                        textColor: UIColor(Color.primary),
                        textStyle: .subheadline,
                        fontWeight: .semibold,
                        textAlignment: .right,
                        cancelButtonIsPresented: true,
                        navigationRowIsPresented: true,
                        destination: { destination in self.destination = destination }
                    )
                    .focused($focusedField, equals: .secondary(id: rowID))
                }
            }
        }
        .onChange(of: focusedField) { oldValue, newValue in
            guard oldValue == .primary(id: rowID) || oldValue == .secondary(id: rowID) else { return }
            // If focus changes to a new row, apply in progress opperation if there is one, commit the new value
            if newValue != .primary(id: rowID) && newValue != .secondary(id: rowID) {
                onSubmit()
            }
        }
        .sheet(item: $destination) { destination in
            switch destination {
            case .moveMoney:
                MoveMoneyView()
            case .detail:
                CategoryDetailView()
            }
        }
    }
    
    private func updateAssignedAmountLocal(primary: String? = nil, secondary: String? = nil, operation: String? = nil) {
        if let primary, primary != localValues.primary {
            self.localValues.primary = primary
        }
        
        if let secondary, secondary != localValues.secondary {
            self.localValues.secondary = secondary
        }
        
        if let operation, operation != localValues.operation {
            self.localValues.operation = operation
        }
    }
    
    private func onEquals() {
        focusedField = .primary(id: rowID)
        
        DispatchQueue.main.async {
            applyOperation()
        }
    }
    
    private func onSubmit() {
        focusedField = nil
        // If there are primary and secondary values, apply operation (this should fire on secondary text field only)
        if !localValues.operation.isEmpty {
            applyOperation()
        }
        intent(.updateAssignedAmount(categoryId: category.id, monthYear: monthYear, amount: localValues.primary))
        localValues.lastCommitted = localValues.primary // Update lastComitted to the new primary value
    }
    
    private func onCancel() {
        focusedField = nil
        let lastCommittedDecimal = localValues.lastCommitted.decimalValue
        localValues.primary = lastCommittedDecimal.formatted(.currency(code: currencyCode))
        if localValues.operation != "" { localValues.operation = "" }
        localValues.secondary = Decimal(0.00).formatted(.currency(code: currencyCode))
    }
    
    private func handle(operation: String) {
        if focusedField != .secondary(id: rowID) { focusedField = .secondary(id: rowID) }
        if !localValues.operation.isEmpty { applyOperation() } // If an operation in progress, commit the operation
        localValues.operation = operation // Set the operation for the next entry
    }
    
    private func applyOperation() {
        // Get Decimal values from Strings to perform operation
        let primary = localValues.primary.decimalValue
        let secondary = localValues.secondary.decimalValue
        
        // Perform operation on Decimal values
        let newTotal = localValues.operation == "+" ? primary + secondary : primary - secondary
        
        localValues.primary = newTotal.formatted(.currency(code: currencyCode)) // Update to be result of operation
        localValues.secondary = Decimal(0.00).formatted(.currency(code: currencyCode)) // Reset for new input
        localValues.operation = "" // Reset for new input
    }
}

#Preview {
    @Previewable @State var localValues = AssignedValues(
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
        localValues: $localValues
    )
}
