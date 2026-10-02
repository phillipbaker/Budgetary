//
//  AssignMoneyView.swift
//  Budgetary
//
//  Created by Phillip Baker on 28/01/2025.
//

@MainActor
@Observable
final class AssignMoneyViewModel {
    var localValues: AssignedValues
    var focusIntent: FocusIntent
    var destination: Destination?
    
    enum FocusIntent {
        case primary(id: BudgetRowID?)
        case secondary(id: BudgetRowID?)
        case none
    }
    
    enum Destination: String, Identifiable {
        case moveMoney
        case detail
        
        var id: String { rawValue }
    }
    
    init(
        localValues: AssignedValues,
        focusIntent: FocusIntent = .none
    ) {
        self.localValues = localValues
        self.focusIntent = focusIntent
    }
    
    var operationString: String {
        switch localValues.operation {
        case .add: return "+"
        case .subtract: return "-"
        default: return ""
        }
    }
    
    func handle(destination: Destination?) {
        switch destination {
        case .moveMoney:
            self.destination = .moveMoney
        case .detail:
            self.destination = .detail
        case nil:
            self.destination = nil
        }
    }
    
    func updatePrimary(_ value: Decimal) {
        localValues.primary = value
    }
    
    func updateSecondary(_ value: Decimal) {
        localValues.secondary = value
    }
    
    func onDeleteWhileEmpty() {
        localValues.operation = nil
    }
    
    func onEquals() {
        applyOperation()
    }
    
    func onSubmit() {
        focusIntent = .none
        if localValues.operation != nil {
            applyOperation()
        }
    // TODO: Connect to action
    // action(.updateAssignedAmount(assignedAmount: localValues.primary, categoryID: rowID, monthYear: monthYear))
        localValues.lastCommitted = localValues.primary
    }
    
    func onCancel() throws {
        focusIntent = .none
        localValues.primary = localValues.lastCommitted
        if localValues.operation != nil { localValues.operation = nil }
        localValues.secondary = 0
    }
    
    func handle(operation: AmountOperation) {
        if localValues.operation != nil { applyOperation() } // If operation in progress, commit
        localValues.operation = operation // Set the operation for the next entry
    }
    
    func applyOperation() {
        let result = (localValues.operation == .add) ? localValues.primary + localValues.secondary : localValues.primary - localValues.secondary
        localValues.primary = result // Update to be result of operation
        localValues.secondary = 0 // Reset for new input
        localValues.operation = nil // Reset for new input
    }
    
    private var operationResult: Decimal {
        let signedPrimary = localValues.primaryIsNegative ? -localValues.primary : localValues.primary
        
        switch localValues.operation {
        case .add:
            return signedPrimary + localValues.secondary
        case .subtract:
            return signedPrimary - localValues.secondary
        default:
            // If self.operation is .none
            return signedPrimary
        }
    }
}

import SwiftUI

struct AssignMoneyView<BudgetRow: BudgetRowPresentation>: View {
    let rowID: BudgetRowID
    let monthYear: MonthYear
    let currencyCode: String
    let action: (BudgetAction) -> Void
    
    @Binding var localValues: AssignedValues
    @FocusState var focusedField: BudgetRowView<BudgetRow>.FocusedField?
    
    @State var destination: Destination?
    
    enum Destination: String, Identifiable {
        case moveMoney
        case detail
        
        var id: String { rawValue }
    }
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            CurrencyTextField(
                value: $localValues.primary,
                onSubmit: onSubmit,
                onCancel: onCancel,
                onOperation: handle(operation:),
                onTextChanged: updatePrimary,
                textStyle: .subheadline,
                textAlignment: .right,
                primaryIsNegative: localValues.primaryIsNegative,
                navigationRowIsPresented: true,
                destination: { dest in
                    // Map CurrencyTextField.Destination? -> AssignMoneyView.Destination?
                    switch dest {
                    case .moveMoney?: self.destination = .moveMoney
                    case .detail?: self.destination = .detail
                    case nil: self.destination = nil
                    }
                }
            )
            .focused($focusedField, equals: .primary(id: rowID))
            
            if !operationString.isEmpty {
                HStack(spacing: 2) {
                    Text(operationString)
                    CurrencyTextField(
                        value: $localValues.secondary,
                        onEquals: onEquals,
                        onSubmit: onSubmit,
                        onCancel: onCancel,
                        onOperation: handle(operation:),
                        onTextChanged: updateSecondary,
                        onDeleteWhileEmpty: onDeleteWhileEmpty,
                        textStyle: .subheadline,
                        textAlignment: .right,
                        navigationRowIsPresented: true,
                        destination: { dest in
                            // Map CurrencyTextField.Destination? -> AssignMoneyView.Destination?
                            switch dest {
                            case .moveMoney?: self.destination = .moveMoney
                            case .detail?: self.destination = .detail
                            case nil: self.destination = nil
                            }
                        }
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
    
    private var operationString: String {
        switch localValues.operation {
        case .add: return "+"
        case .subtract: return "-"
        default: return ""
        }
    }
    
    func updatePrimary(_ value: Decimal) {
        localValues.primary = value
    }
    
    func updateSecondary(_ value: Decimal) {
        localValues.secondary = value
    }
    
    private func onEquals() {
        focusedField = .primary(id: rowID)
        applyOperation()
    }

    func onDeleteWhileEmpty() {
        guard focusedField == .secondary(id: rowID) else { return }
        focusedField = .primary(id: rowID)
        localValues.operation = nil
    }
    
    private func onSubmit() {
        focusedField = nil
        if localValues.operation != nil {
            applyOperation()
        }

        action(.updateAssignedAmount(assignedAmount: localValues.primary, categoryID: rowID, monthYear: monthYear))
        localValues.lastCommitted = localValues.primary
    }
    
    private func onCancel() {
        focusedField = nil
        localValues.primary = localValues.lastCommitted
        localValues.operation = nil
        localValues.secondary = 0
    }
    
    private func handle(operation: AmountOperation) {
        if focusedField != .secondary(id: rowID) { focusedField = .secondary(id: rowID) }
        if localValues.operation != nil { applyOperation() } // If an operation in progress, commit the operation
        localValues.operation = operation // Set the operation for the next entry
    }
    
    private func applyOperation() {
        let newTotal = localValues.operation == .add ? localValues.primary + localValues.secondary : localValues.primary - localValues.secondary
        localValues.primary = newTotal // Update to be result of operation
        localValues.secondary = 0 // Reset for new input
        localValues.operation = nil // Reset for new input
    }
}

#Preview {
    @Previewable @State var localValues = AssignedValues(
        primary: 9.99,
        secondary: 0.00,
        operation: .add,
        lastCommitted: 0.00,
        primaryIsNegative: false
    )
    
    AssignMoneyView<CategoryRowPresentation<CategoryAssignedPresentation, CategoryActivityPresentation, CategoryAvailablePresentation>>(
        rowID: .init(),
        monthYear: .currentMonthYear,
        currencyCode: "GBP",
        action: { _ in },
        localValues: $localValues
    )
}
