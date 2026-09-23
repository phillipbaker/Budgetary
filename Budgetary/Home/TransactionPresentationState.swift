//
//  TransactionPresentationState.swift
//  Budgetary
//
//  Created by Phillip Baker on 22/01/2026.
//

import SwiftUI
import Foundation

public struct TransactionPresentationState: Sendable {
    let currencyCode: String
    let isNewTransaction: Bool
    let transaction: TransactionPresentation?
}
    
    // MARK: - TextFields

//    mutating func onEquals() {
//        if focusedField != .primaryOperand { focusedField = .primaryOperand }
//        
//        DispatchQueue.main.async {
//            applyOperation()
//        }
//    }
//    
//    mutating func onSubmit() {
//        if focusedField != nil { focusedField = nil }
//        // If there are primary and secondary values, apply operation
//        if !localValues.operation.isEmpty {
//            applyOperation()
//        }
//    }
//    
//    mutating func handle(operation: String) {
//        if focusedField != .secondaryOperand { focusedField = .secondaryOperand }
//        if !localValues.operation.isEmpty { applyOperation() } // If an operation in progress, commit the operation
//        localValues.operation = operation // Set the operation for the next entry
//    }
//    
//    func operation(of primary: Decimal, and secondary: Decimal) -> Decimal {
//        switch localValues.operation {
//        case "+":
//            return primary + secondary
//        case "-":
//            return primary - secondary
//        default:
//            // If self.operation is empty or anything other than "+" or "-"...
//            return primary
//        }
//    }
//    
//    mutating func applyOperation() {
//        guard let primary = decimal(from: localValues.primary) else { return }
//        guard let secondary = decimal(from: localValues.secondary) else { return }
//        
//        // Perform operation on Decimal values
//        let newTotal = localValues.operation == "+" ? primary + secondary : primary - secondary
//        
//        localValues.primary = newTotal.formatted(.currency(code: currencyCode)) // Update to be result of operation
//        localValues.secondary = Decimal(0.00).formatted(.currency(code: currencyCode)) // Reset for new input
//        localValues.operation = "" // Reset for new input
//    }
//    
//    mutating func onTextChanged(primaryOperand: String? = nil, secondaryOperand: String? = nil, operation: String? = nil) {
//        if let primaryOperand, primaryOperand != localValues.primary {
//            localValues.primary = primaryOperand
//        }
//        
//        if let secondaryOperand, secondaryOperand != localValues.secondary {
//            localValues.secondary = secondaryOperand
//        }
//        
//        if let operation, operation != localValues.operation {
//            localValues.operation = operation
//        }
//    }
//    
//    // MARK: - View State
//    
//    mutating func onChangeOfTransactionType() {
//        // add/remove minus sign from front of amount string
//        guard let primary = decimal(from: localValues.primary) else { return }
//        guard let secondary = decimal(from: localValues.secondary) else { return }
//        
//        switch transactionDetail.type {
//        case .inflow:
//            if localValues.operation.isEmpty || abs(primary) > abs(secondary),
//               localValues.primary.first == "-" {
//                localValues.primary.remove(at: localValues.primary.startIndex)
//            }
//        case .outflow:
//            if localValues.operation.isEmpty || abs(primary) > abs(secondary),
//               localValues.primary.first != "-" {
//                localValues.primary.insert("-", at: localValues.primary.startIndex)
//            }
//        }
//    }
//    
//    mutating func onChangeOfSecondaryOperand() {
//        guard let primary = decimal(from: localValues.primary) else { return }
//        guard let secondary = decimal(from: localValues.secondary) else { return }
//        
//        // toggle transaction type
//        if transactionDetail.type == .inflow {
//            if operation(of: primary, and: secondary) < 0 {
//                transactionDetail.type = .outflow
//            }
//        } else {
//            // transactionType == .outflow
//            if operation(of: primary, and: secondary) > 0 {
//                transactionDetail.type = .inflow
//            }
//        }
//        
//        // enable/disable transaction type picker
//        if abs(secondary) > abs(primary) {
//            if !transactionTypePickerIsDisabled { transactionTypePickerIsDisabled = true }
//        } else {
//            if transactionTypePickerIsDisabled { transactionTypePickerIsDisabled = false }
//        }
//    }
//    
//    mutating func onChangeOfDestination(from oldValue: TransactionPresentationState.Destination?) {
//        if oldValue == nil {
//            if focusedField != nil { focusedField = nil }
//            if isFirstLaunch == true { isFirstLaunch = false }
//        }
//    }
//    
//    mutating func onAppear() {
//        if isNewTransaction && isFirstLaunch {
//            if focusedField != .primaryOperand { focusedField = .primaryOperand }
//            isFirstLaunch = false
//        } else {
//            if focusedField != nil { focusedField = nil }
//        }
//    }
//    
//    func decimal(from string: String) -> Decimal? {
//        return string.decimalValue()
//    }
//    
//    var isNewTransaction: Bool {
//        if transactionDetail.memo == "",
//           transactionDetail.amount == "",
//           transactionDetail.isCleared == false,
//           transactionDetail.type == .outflow,
//           transactionDetail.payee == nil,
//           transactionDetail.category == nil {
//            return true
//        }
//        return false
//    }

//import SwiftUI

//extension TransactionPresentationState {
//    func onChangeOfDatePickerIsPresented(proxy: ScrollViewProxy) {
//        withAnimation {
//            if datePickerIsPresented == true {
//                proxy.scrollTo("datePicker", anchor: .bottom)
//            } else {
//                proxy.scrollTo("list", anchor: .top)
//            }
//        }
//    }
//    
//    mutating func onChangeOfDate() {
//        // when a new date is selected, close the picker
//        withAnimation { datePickerIsPresented = false }
//    }
//}
