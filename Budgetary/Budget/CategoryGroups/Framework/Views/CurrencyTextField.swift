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
    let onEquals: () -> Void
    let onSubmit: () -> Void
    let onCancel: () -> Void
    let onOperation: (String) -> Void
    let onTextChanged: ((String) -> Void)?
    let textColor: UIColor
    let textStyle: UIFont.TextStyle
    let fontWeight: UIFont.Weight
    let textAlignment: NSTextAlignment
    let cancelButtonIsPresented: Bool
    let navigationRowIsPresented: Bool
    let destination: (AssignMoneyView.Destination?) -> Void

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.addTarget(context.coordinator, action: #selector(Coordinator.textIsChanging), for: .editingChanged)
        context.coordinator.textField = textField
        
        let font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: textStyle).pointSize, weight: fontWeight)
        let metrics = UIFontMetrics(forTextStyle: textStyle)
        let dynamicFont = metrics.scaledFont(for: font)
        textField.font = dynamicFont
        textField.textAlignment = textAlignment
        
        let keyboardVC = UIHostingController(
            rootView: AssignMoneyKeyboard(
                onSubmitKeyTapped: context.coordinator.submitKeyTapped,
                onCancelKeyTapped: onCancel,
                onEqualsKeyTapped: onEquals,
                onDeleteKeyTapped: context.coordinator.deleteKeyTapped,
                onNumberKeyTapped: { number in context.coordinator.insert(number) },
                onOperationKeyTapped: onOperation,
                destination: destination,
                cancelButtonIsPresented: cancelButtonIsPresented,
                navigationRowIsPresented: navigationRowIsPresented
            )
        )
        
        keyboardVC.view.translatesAutoresizingMaskIntoConstraints = false
        keyboardVC.view.backgroundColor = .clear
        context.coordinator.hostingController = keyboardVC
        textField.inputView = keyboardVC.view

        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.textColor = textColor

        if text.isEmpty {
            // Show £0.00 if field is empty
            let formattedZero = Decimal(0).formatted(.currency(code: currencyCode))
            text = formattedZero
            uiView.text = formattedZero
            uiView.invalidateIntrinsicContentSize() // Force re-layout
        } else if uiView.text != text {
            uiView.text = text
            uiView.invalidateIntrinsicContentSize() // Force re-layout
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(
            text: $text,
            currencyCode: currencyCode,
            onSubmit: onSubmit,
            onTextChanged: onTextChanged
        )
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        let currencyCode: String

        private var isFirstKeyPress = true

        let onSubmit: () -> Void
        let onTextChanged: ((String) -> Void)?

        weak var hostingController: UIHostingController<AssignMoneyKeyboard>?

        weak var textField: UITextField?

        init(
            text: Binding<String>,
            currencyCode: String,
            onSubmit: @escaping () -> Void,
            onTextChanged: ((String) -> Void)?
        ) {
            self._text = text
            self.currencyCode = currencyCode
            self.onSubmit = onSubmit
            self.onTextChanged = onTextChanged
        }

        func insert(_ newText: String) {
            guard let textField, let selectedRange = textField.selectedTextRange else { return }
            textInput(textField, replaceTextAt: selectedRange, with: newText)
            text = textField.text ?? ""
        }
        
        func deleteKeyTapped() {
            guard let textField, let selectedTextRange = textField.selectedTextRange else { return }

            if let startPosition = textField.position(from: selectedTextRange.start, offset: -1),
               let rangeToDelete = textField.textRange(from: startPosition, to: selectedTextRange.end) {
                textInput(textField, replaceTextAt: rangeToDelete, with: "")
                text = textField.text ?? ""
            } else {
                // Handle empty input or edge case
                // e.g., trigger some fallback behavior
                
            }
        }
        
        func submitKeyTapped() {
            guard let textField else { return }
            if let delegate = textField.delegate {
                _ = delegate.textFieldShouldReturn?(textField)
            }
        }
        
        private func textInput(_ input: UITextInput, replaceTextAt range: UITextRange?, with string: String?) {
            guard let range = range else { return }

            let startPosition = input.offset(from: input.beginningOfDocument, to: range.start)
            let length = input.offset(from: range.start, to: range.end)
            let nsRange = NSRange(location: startPosition, length: length)

            if textInput(input, shouldChangeCharactersIn: nsRange, with: string) {
                input.replace(range, withText: string ?? "")
            }
        }
        
        private func textInput(_ input: UITextInput, shouldChangeCharactersIn range: NSRange, with string: String?) -> Bool {
            if let textField = input as? UITextField {
                if let shouldChange = textField.delegate?.textField?(
                    textField,
                    shouldChangeCharactersIn: range,
                    replacementString: string ?? ""
                ) {
                    return shouldChange
                }
            }
            return true // Default
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
                
                // Replacing the leading minus sign on primary operand (secondary never leads with "-")
                let updatedString = text.first == "-" ? "-" + currencyString(for: currencyCode, from: decimalValue): currencyString(for: currencyCode, from: decimalValue)
                
                if let range = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument) {
                    textField.replace(range, withText: updatedString)
                }
                
                isFirstKeyPress = false
                return false
            }
            
            // If not first key press or first key press is "" (delete), edit existing textField value
            let input = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            let decimalValue = decimalWholeNumber(from: input)
            
            // Replacing the leading minus sign on primary operand (secondary never leads with "-")
            let updatedString = text.first == "-" ? "-" + currencyString(for: currencyCode, from: decimalValue) : currencyString(for: currencyCode, from: decimalValue)
            
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
