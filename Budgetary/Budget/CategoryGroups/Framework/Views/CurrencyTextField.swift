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
    @FocusState var focus: CategoryRowView.FocusedField?

    let onEquals: () -> Void
    let onSubmit: () -> Void
    let onCancel: () -> Void
    let onOperation: (String) -> Void
    let onTextChanged: ((String) -> Void)?

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.text = text
        textField.textAlignment = .right
        
        let font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .subheadline).pointSize, weight: .semibold)
        let metrics = UIFontMetrics(forTextStyle: .subheadline)
        let dynamicFont = metrics.scaledFont(for: font)
        textField.font = dynamicFont
 
        textField.delegate = context.coordinator
        textField.addTarget(context.coordinator, action: #selector(Coordinator.textIsChanging), for: .editingChanged)
        textField.inputView = UIHostingController(
            rootView: BudgetaryNumberPad(
                target: textField,
                onCancel: onCancel,
                onEquals: onEquals,
                onOperation: onOperation
            )
        ).view
        textField.inputView?.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        if text != uiView.text {
            uiView.text = text
        }
        uiView.invalidateIntrinsicContentSize() // Force re-layout
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(
            currencyCode: currencyCode,
            onSubmit: onSubmit,
            onTextChanged: onTextChanged
        )
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        let currencyCode: String
        
        private var isFirstKeyPress = true
        
        let onSubmit: () -> Void
        let onTextChanged: ((String) -> Void)?
        
        init(
            currencyCode: String,
            onSubmit: @escaping () -> Void,
            onTextChanged: ((String) -> Void)?
        ) {
            self.currencyCode = currencyCode
            self.onSubmit = onSubmit
            self.onTextChanged = onTextChanged
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
            textField.invalidateIntrinsicContentSize() // Ensure resizing
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            onSubmit()
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
