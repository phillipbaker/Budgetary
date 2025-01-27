//
//  CurrencyTextField.swift
//  Budgetary
//
//  Created by Phillip Baker on 09/01/2025.
//

import SwiftUI

struct CurrencyTextField: UIViewRepresentable {
    @Binding var text: String
    let currencyCode: String
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.keyboardType = .numberPad
        textField.textAlignment = .right
        textField.addTarget(context.coordinator, action: #selector(Coordinator.textIsChanging), for: .editingChanged)
        textField.font = .preferredFont(forTextStyle: .subheadline)
        textField.text = text
        
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        if text != uiView.text {
            uiView.text = text
        }
    }
    
    func makeCoordinator() -> Coordinate {
        return Coordinator(text: $text, currencyCode: currencyCode)
    }
    
    class Coordinate: NSObject, UITextFieldDelegate {
        @Binding var text: String
        let currencyCode: String
        
        private var isFirstKeyPress = true
        
        init(text: Binding<String>, currencyCode: String) {
            self._text = text
            self.currencyCode = currencyCode
        }
        
        @objc func textIsChanging(_ textField: UITextField) {
            text = textField.text ?? "0.00"
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            isFirstKeyPress = true
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            if let selectedTextRange = textField.selectedTextRange, selectedTextRange.isEmpty {
                DispatchQueue.main.async {
                    textField.selectedTextRange = textField.textRange(from: textField.endOfDocument, to: textField.endOfDocument)
                }
            }
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            /// This method is called before the UITextField text changes. It returns `TRUE` to change text according to user input.
            /// We are manually updating the text so we return `FALSE`

            if isFirstKeyPress {
                // Create a decimal whole number value from the `string` input character
                // For example "£34.56" becomes 3456.
                let decimalValue = decimalWholeNumber(from: string)
                
                // Set the textField text to the new value, restoring 2 decimal places and adding currency symbol
                textField.text = currencyString(for: currencyCode, from: decimalValue)
                                                                         
                isFirstKeyPress = false
                return false
            }
            
            let input = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            let decimalValue = decimalWholeNumber(from: input)
            let updatedString = currencyString(for: currencyCode, from: decimalValue)
            
            if let range = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument) {
                textField.replace(range, withText: updatedString)
            }
            
            return false
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
