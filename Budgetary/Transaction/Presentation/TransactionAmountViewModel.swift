//
//  TransactionAmountViewModel.swift
//  Budgetary
//
//  Created by Phillip Baker on 15/02/2026.
//

import SwiftUI

@MainActor
@Observable
final class TransactionAmountViewModel {
    
    // MARK: Stored State

    private(set) var calculatorState: CalculatorState = .idle(lhs: 0)
    private(set) var userIntendedType: TransactionTypePresentation = .outflow

    var focusIntent: FocusIntent = .none
    var isFirstLaunch: Bool = true
    var datePickerIsPresented: Bool = false
    var deleteTransactionConfirmationDialogIsPresented: Bool = false
    
    // MARK: Derived State
    
    var primary: Decimal {
        get { calculatorState.primary }
        set { calculatorState = calculatorState.settingPrimary(newValue) }
    }

    var secondary: Decimal {
        get { calculatorState.secondary ?? 0 }
        set { calculatorState = calculatorState.settingSecondary(newValue) }
    }
    
    var primaryIsNegative: Bool {
        userIntendedType == .outflow
    }
    
    private var signedPrimary: Decimal {
        userIntendedType == .outflow ? -calculatorState.primary : calculatorState.primary
    }
    
    var result: Decimal {
        switch calculatorState {
        case .idle:
            return signedPrimary
        case .pendingOperation(_, let op, let rhs):
            switch op {
            case .add:
                return signedPrimary + rhs
            case .subtract:
                return signedPrimary - rhs
            }
        }
    }
    
    var transactionType: TransactionTypePresentation {
        switch calculatorState {
        case .idle:
            return userIntendedType
        case .pendingOperation:
            if result > 0 { return .inflow }
            if result < 0 { return .outflow }
            return userIntendedType
        }
    }
    
    var transactionTypePickerIsDisabled: Bool {
        guard case .pendingOperation(let lhs, _, let rhs) = calculatorState else {
            return false
        }
        return abs(lhs) < abs(rhs)
    }
    
    var operationString: String {
        switch calculatorState.operation {
        case .add:      return "+"
        case .subtract: return "-"
        case nil:       return ""
        }
    }
    
    // MARK: Focus
    
    enum FocusIntent: Equatable {
        case primary, secondary, none
    }
    
    // MARK: Init
    
    init(
        calculatorState: CalculatorState = .idle(lhs: 0),
        userIntendedType: TransactionTypePresentation = .outflow,
        focusIntent: FocusIntent = .none
    ) {
        self.calculatorState = calculatorState
        self.userIntendedType = userIntendedType
        self.focusIntent = focusIntent
    }
    
    // MARK: Input

    func updatePrimary(_ value: Decimal) {
        calculatorState = calculatorState.settingPrimary(value)
    }
    
    func updateSecondary(_ value: Decimal) {
        calculatorState = calculatorState.settingSecondary(value)
    }
    
    func onOperation(_ operation: AmountOperation) {
        if focusIntent != .secondary { focusIntent = .secondary }
        
        // If a calculation is already in progress, commit it first
        if case .pendingOperation = calculatorState {
            let committedResult = abs(result)
            let committedType = transactionType
            userIntendedType = committedType
            calculatorState = .idle(lhs: committedResult)
        }
        
        // Now open the new operation from the clean idle state
        calculatorState = calculatorState.applyingOperation(operation)
    }
    
    func onEquals() {
        if focusIntent != .primary { focusIntent = .primary }
        commit()
    }
    
    func onSubmit() {
        if focusIntent != .none { focusIntent = .none }
        commit()
        // TODO: Bubble up to parent view model
    }
    
    func onDeleteWhileEmpty() {
        guard focusIntent == .secondary else { return }
        focusIntent = .primary
        calculatorState = calculatorState.cancelledOperation()
    }
    
    // MARK: Transaction Type

    func setTransactionType(to newType: TransactionTypePresentation) {
        guard !transactionTypePickerIsDisabled else { return }
        guard newType != userIntendedType else { return }
        userIntendedType = newType
    }
    
    // MARK: Category
    
    func onAddCategory(name: String, groupID: String) {
        // TODO: implement
    }
    
    // MARK: Delete
    
    func deleteTransactionButtonTapped() {
        deleteTransactionConfirmationDialogIsPresented = true
    }
    
    func cancelDeleteButtonTapped() {
        deleteTransactionConfirmationDialogIsPresented = false
    }
    
    func confirmDeleteTransactionButtonTapped() {
        deleteTransactionConfirmationDialogIsPresented = false
    }
    
    // MARK: Date Picker
    
    func datePickerButtonTapped() {
        datePickerIsPresented.toggle()
    }
    
    // MARK: Private
    
    private func commit() {
        guard case .pendingOperation = calculatorState else { return }
        
        // Capture both values before any mutation
        let committedResult = abs(result)
        let committedType = transactionType  // read while state is still .pendingOperation
        
        // Now mutate
        userIntendedType = committedType
        calculatorState = .idle(lhs: committedResult)
    }
}
