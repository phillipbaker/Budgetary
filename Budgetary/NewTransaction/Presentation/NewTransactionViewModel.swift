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
    var amount: String
    var payee: PayeePresentation?
    var category: TransactionCategoryPresentation?
    var isCleared: Bool
    var transactionType: TransactionType
    var account: BudgetAccountPresentation?
    
    var destination: Destination?
    var localValues: Operands
    var pickerIsDisabled: Bool
    var showingDatePicker: Bool
    var isFirstLaunch: Bool

    enum FocusedField { case primaryOperand, secondaryOperand }

    enum Destination: String, Identifiable {
        case payee, category, account
        var id: String { rawValue }
    }
    
    init(
        date: Date = .now.startOfDay(),
        amount: String = Decimal(0).formatted(.currency(code: "GBP")),
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
        self.amount = amount
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
            amount: self.amount,
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
}
