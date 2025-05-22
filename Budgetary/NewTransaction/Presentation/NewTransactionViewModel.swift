//
//  NewTransactionViewModel.swift
//  Budgetary
//
//  Created by Phillip Baker on 21/05/2025.
//

import Factory
import SwiftUI

enum TransactionType: String, CaseIterable, Identifiable {
    case outflow, inflow
    var id: String { rawValue }
}

@Observable
final class NewTransactionViewModel {
    let addTransactionUseCase: AddTransactionUseCase = Container.shared.addTransactionUseCase()

    var date: Date
    var currencyCode: String
    var payee: PayeePresentation?
    var category: TransactionCategoryPresentation?
    var isCleared: Bool
    var transactionType: TransactionType
    var account: BudgetAccountPresentation?
    
    var destination: Destination?
    var focusedField: FocusedField?
    var localValues: Operands
    var pickerIsDisabled: Bool
    var showingDatePicker: Bool
    var isFirstLaunch: Bool

    enum FocusedField {
        case primaryOperand
        case secondaryOperand
    }

    enum Destination: String, Identifiable {
        case payee, category, account
        var id: String { rawValue }
    }
    
    init(
        date: Date = .now.startOfDay(),
        currencyCode: String = "GBP",
        payee: PayeePresentation? = nil,
        category: TransactionCategoryPresentation? = nil,
        isCleared: Bool = false,
        transactionType: TransactionType = .outflow,
        account: BudgetAccountPresentation? = nil,
        destination: Destination? = nil,
        showingDatePicker: Bool = false,
        localValues: Operands = .init(primary: "", secondary: "", operation: ""),
        pickerIsDisabled: Bool = false,
        isFirstLaunch: Bool = true
    ) {
        self.date = date
        self.currencyCode = currencyCode
        self.payee = payee
        self.category = category
        self.isCleared = isCleared
        self.transactionType = transactionType
        self.account = account
        self.destination = destination
        self.showingDatePicker = showingDatePicker
        self.localValues = localValues
        self.pickerIsDisabled = pickerIsDisabled
        self.isFirstLaunch = isFirstLaunch
    }
    
    @MainActor
    func handle(intent: NewTransactionIntent) {
        Task {
            switch intent {
            case .addTransaction:
                await self.addTransaction()
            }
        }
    }
    
    private func addTransaction() async {
        let request = AddTransactionRequestModel(
            date: self.date,
            amount: self.localValues.primary,
            payeeId: self.payee?.id,
            categoryId: self.category?.id,
            isCleared: self.isCleared,
            transactionType: self.transactionType,
            accountId: self.account?.id
        )
        await addTransactionUseCase.execute(request: request)
    }
    
    func applyOperation(to primary: Decimal, and secondary: Decimal) -> Decimal {
        switch self.localValues.operation {
        case "+":
            return primary + secondary
        case "-":
            return primary - secondary
        default:
            // If self.operation is empty or anything other than "+" or "-"...
            return self.localValues.primary.decimalValue
        }
    }
    
    func payeePickerButtonTapped() {
        self.destination = .payee
    }
    
    func accountPickerButtonTapped() {
        self.destination = .account
    }
    
    func categoryPickerButtonTapped() {
        self.destination = .category
    }

    @MainActor
    func onEquals() {
        focusedField = .primaryOperand
        
        DispatchQueue.main.async {
            self.applyOperation()
        }
    }
    
    func onSubmit() {
        focusedField = nil
        // If there are primary and secondary values, apply operation
        if !self.localValues.operation.isEmpty {
            applyOperation()
        }
    }
    
    func handle(operation: String) {
        if focusedField != .secondaryOperand { focusedField = .secondaryOperand }
        if !self.localValues.operation.isEmpty { applyOperation() } // If an operation in progress, commit the operation
        self.localValues.operation = operation // Set the operation for the next entry
    }
    
    func applyOperation() {
        // Get Decimal values from Strings to perform operation
        let primary = localValues.primary.decimalValue
        let secondary = localValues.secondary.decimalValue
        
        // Perform operation on Decimal values
        let newTotal = self.localValues.operation == "+" ? primary + secondary : primary - secondary
        
        self.localValues.primary = newTotal.formatted(.currency(code: currencyCode)) // Update to be result of operation
        self.localValues.secondary = Decimal(0.00).formatted(.currency(code: currencyCode)) // Reset for new input
        self.localValues.operation = "" // Reset for new input
    }
    
    func onTextChanged(primaryOperand: String? = nil, secondaryOperand: String? = nil, operation: String? = nil) {
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
