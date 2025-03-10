//
//  CurrencyTextField.swift
//  Budgetary
//
//  Created by Phillip Baker on 09/01/2025.
//

import UIKit

//class CurrencyUITextField: UITextField {
//    @Binding var value: String?
//    
//    init(value: Binding<String?>) {
//        self._value = value
//        super.init(frame: .zero)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}

import SwiftUI

struct CurrencyTextField: UIViewRepresentable {
    @Binding var text: String
    let currencyCode: String
    let onTextChanged: ((String) -> Void)?
    let onUpdateAssignedAmount: () -> Void
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.text = text
        textField.textAlignment = .right
        textField.font = .preferredFont(forTextStyle: .subheadline)
        textField.delegate = context.coordinator
        textField.addTarget(context.coordinator, action: #selector(Coordinator.textIsChanging), for: .editingChanged)
        textField.inputView = UIHostingController(rootView: BudgetaryNumberPad(
            target: textField,
            cancel: { text = context.coordinator.lastCommittedText }
        )).view
        textField.inputView?.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        if text != uiView.text {
            uiView.text = text
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(
            text: $text,
            currencyCode: currencyCode,
            onTextChanged: onTextChanged,
            onUpdateAssignedAmount: onUpdateAssignedAmount
        )
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        let currencyCode: String
        let onTextChanged: ((String) -> Void)?
        let onUpdateAssignedAmount: () -> Void
        
        var lastCommittedText: String
        private var isFirstKeyPress = true
        
        init(
            text: Binding<String>,
            currencyCode: String,
            onTextChanged: ((String) -> Void)?,
            onUpdateAssignedAmount: @escaping () -> Void
        ) {
            self._text = text
            self.currencyCode = currencyCode
            self.onTextChanged = onTextChanged
            self.onUpdateAssignedAmount = onUpdateAssignedAmount
            self.lastCommittedText = text.wrappedValue
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            isFirstKeyPress = true
        }
        
        @objc func textIsChanging(_ textField: UITextField) {
            onTextChanged?(textField.text ?? "Error")
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            if let selectedTextRange = textField.selectedTextRange, selectedTextRange.isEmpty {
                DispatchQueue.main.async {
                    textField.selectedTextRange = textField.textRange(from: textField.endOfDocument, to: textField.endOfDocument)
                }
            }
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            onUpdateAssignedAmount()
            textField.resignFirstResponder()
            return true
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            /// This method is called before the UITextField text changes. It returns `TRUE` to change text according to user input.
            /// We are manually updating the text so we return `FALSE`
            
            if isFirstKeyPress && string != "" {
                // Create a new decimal whole number value from the first `string` input character
                let decimalValue = decimalWholeNumber(from: string)

                let updatedString = currencyString(for: currencyCode, from: decimalValue)
                
                if let range = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument) {
                    textField.replace(range, withText: updatedString)
                }
                
                isFirstKeyPress = false
                return false
            }
            
            // If not first key press or first key press is "" (delete), edit existing textField value
            let input = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            let decimalValue = decimalWholeNumber(from: input)
            let updatedString = currencyString(for: currencyCode, from: decimalValue)
            
            if let range = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument) {
                textField.replace(range, withText: updatedString)
            }
            
            return false
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            lastCommittedText = text
        }
        
        private func currencyString(for code: String, from decimal: Decimal) -> String {
            return (decimal / pow(10, 2)).formatted(.currency(code: code))
        }
        
        private func decimalWholeNumber(from string: String) -> Decimal {
            return Decimal(string: string.digits) ?? 0
        }
    }
}

extension StringProtocol where Self: RangeReplaceableCollection {
    var digits: Self { filter (\.isWholeNumber) }
}
