//
//  TransactionDetailViewModel.swift
//  Budgetary
//
//  Created by Phillip Baker on 21/05/2025.
//

import Factory
import SwiftUI

@Observable
final class TransactionDetailViewModel {
    @ObservationIgnored let addTransactionUseCase: AddTransactionUseCase = Container.shared.addTransactionUseCase()
    @ObservationIgnored let updateTransactionUseCase: UpdateTransactionUseCase = Container.shared.updateTransactionUseCase()
    @ObservationIgnored let deleteTransactionUseCase: DeleteTransactionUseCase = Container.shared.deleteTransactionUseCase()
    
    let id: String?
    var date: Date
    var memo: String
    var isCleared: Bool
    var transactionType: TransactionType
    var payee: PayeePresentation?

    var category: TransactionCategoryPresentation?
    var account: TransactionAccountPresentation?
    
    var localValues: Operands
    var destination: Destination?
    var currencyCode: String
    var focusedField: FocusedField?
    var isFirstLaunch: Bool
    let isNewTransaction: Bool
    var datePickerIsPresented: Bool
    var transactionTypePickerIsDisabled: Bool
    var deleteTransactionConfirmationDialogIsPresented: Bool

    enum FocusedField {
        case primaryOperand
        case secondaryOperand
    }

    enum Destination: String, Identifiable {
        case payee
        case category
        case account

        var id: String { rawValue }
    }
    
    // MARK: - Init
    
    init(
        transaction: TransactionPresentation?,
        destination: Destination? = nil,
        currencyCode: String = "GBP",
        focusedField: FocusedField? = nil,
        isFirstLaunch: Bool = true,
        isNewTransaction: Bool,
        datePickerIsPresented: Bool = false,
        transactionTypePickerIsDisabled: Bool = false,
        deleteTransactionConfirmationDialogIsPresented: Bool = false,
    ) {
        self.id = transaction?.id
        self.date = transaction?.date ?? .now
        self.memo = transaction?.memo ?? ""
        self.isCleared = transaction?.isCleared ?? false
        self.localValues = Operands(primary: transaction?.amount.value ?? "", secondary: "", operation: "")
        self.transactionType = transaction?.amount.transactionType ?? .outflow
        self.payee = transaction?.payee
        self.category = transaction?.category
        self.account = transaction?.account
        
        self.destination = destination
        self.currencyCode = currencyCode
        self.focusedField = focusedField
        self.isFirstLaunch = isFirstLaunch
        self.isNewTransaction = isNewTransaction
        self.datePickerIsPresented = datePickerIsPresented
        self.transactionTypePickerIsDisabled = transactionTypePickerIsDisabled
        self.deleteTransactionConfirmationDialogIsPresented = deleteTransactionConfirmationDialogIsPresented
    }
    
    // MARK: - Intents
    
    @MainActor
    func handle(intent: TransactionIntent) {
        Task {
            switch intent {
            case .addTransaction:
                await self.addTransaction()
            case .updateTransaction:
                await self.updateTransaction()
            case .deleteTransaction(let id):
                await deleteTransactionUseCase.deleteTransaction(id: id)
            }
        }
    }
    
    private func addTransaction() async {
        let request = TransactionRequestModel(
            id: self.id,
            date: self.date,
            memo: self.memo,
            amount: self.localValues.primary,
            isCleared: self.isCleared,
            transactionType: self.transactionType,
            payee: self.payee,
            category: self.category,
            account: self.account
        )
        await addTransactionUseCase.add(transaction: request)
    }
    
    private func updateTransaction() async {
        let transaction = TransactionRequestModel(
            id: self.id,
            date: self.date,
            memo: self.memo,
            amount: self.localValues.primary,
            isCleared: self.isCleared,
            transactionType: self.transactionType,
            payee: self.payee,
            category: self.category,
            account: self.account
        )
        await updateTransactionUseCase.update(transaction: transaction)
    }
    
    func deleteTransactionButtonTapped() {
        deleteTransactionConfirmationDialogIsPresented = true
    }
    
    func cancelDeleteTransactionButtonTapped() {
        deleteTransactionConfirmationDialogIsPresented = false
    }
    
    @MainActor
    func confirmAddTransactionButtonTapped() {
        withAnimation {
            if focusedField != nil { focusedField = nil }
            // If there are primary and secondary values, apply operation
            if !self.localValues.operation.isEmpty {
                self.applyOperation()
            }
            self.handle(intent: .addTransaction)
            self.destination = nil
        }
    }
    
    @MainActor
    func confirmDeleteTransactionButtonTapped(id: String?) {
        guard let id = self.id else { return }
        if focusedField != nil { focusedField = nil }
        handle(intent: .deleteTransaction(id: id))
    }
    
    // MARK: - Navigation
    
    func payeePickerButtonTapped() {
        self.destination = .payee
    }
    
    func accountPickerButtonTapped() {
        self.destination = .account
    }
    
    func categoryPickerButtonTapped() {
        self.destination = .category
    }
    
    // MARK: - TextFields

    @MainActor
    func onEquals() {
        if focusedField != .primaryOperand { focusedField = .primaryOperand }
        
        DispatchQueue.main.async {
            self.applyOperation()
        }
    }
    
    func onSubmit() {
        print("onSubmit called")
        if focusedField != nil { focusedField = nil }
        print("focusedField: ", focusedField.debugDescription)
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
    
    func operation(of primary: Decimal, and secondary: Decimal) -> Decimal {
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
    
    // MARK: - View State
    
    func datePickerButtonTapped() {
        if focusedField != nil { focusedField = nil }
        datePickerIsPresented.toggle()
    }
    
    func onChangeOfTransactionType() {
        // add/remove minus sign from front of amount string
        switch transactionType {
        case .inflow:
            if localValues.operation.isEmpty || abs(localValues.primary.decimalValue) > abs(localValues.secondary.decimalValue), localValues.primary.first == "-" {
                localValues.primary.remove(at: localValues.primary.startIndex)
            }
        case .outflow:
            if localValues.operation.isEmpty || abs(localValues.primary.decimalValue) > abs(localValues.secondary.decimalValue), localValues.primary.first != "-" {
                localValues.primary.insert("-", at: localValues.primary.startIndex)
            }
        }
    }
    
    func onChangeOfSecondaryOperand() {
        // toggle transaction type
        if transactionType == .inflow {
            if operation(of: localValues.primary.decimalValue, and: localValues.secondary.decimalValue) < 0 {
                transactionType = .outflow
            }
        } else {
            // transactionType == .outflow
            if operation(of: localValues.primary.decimalValue, and: localValues.secondary.decimalValue) > 0 {
                transactionType = .inflow
            }
        }

        // enable/disable transaction type picker
        if abs(localValues.secondary.decimalValue) > abs(localValues.primary.decimalValue) {
            if !transactionTypePickerIsDisabled { transactionTypePickerIsDisabled = true }
        } else {
            if transactionTypePickerIsDisabled { transactionTypePickerIsDisabled = false }
        }
    }
    
    func onChangeOfDatePickerIsPresented(proxy: ScrollViewProxy) {
        withAnimation {
            if datePickerIsPresented == true {
                proxy.scrollTo("datePicker", anchor: .bottom)
            } else {
                proxy.scrollTo("list", anchor: .top)
            }
        }
    }
    func onChangeOfDate() {
        // when a new date is selected, close the picker
        withAnimation { datePickerIsPresented = false }
    }
    
    func onChangeOfDestination(from oldValue: Destination?) {
        if oldValue == nil {
            if focusedField != nil { focusedField = nil }
            if isFirstLaunch == true { isFirstLaunch = false }
        }
    }
    
    func onAppear() {
        if isNewTransaction && isFirstLaunch {
            if focusedField != .primaryOperand { focusedField = .primaryOperand }
            isFirstLaunch = false
        } else {
            if focusedField != nil { focusedField = nil }
        }
    }
}
