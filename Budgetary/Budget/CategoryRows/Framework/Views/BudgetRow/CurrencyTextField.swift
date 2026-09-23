//
//  CurrencyTextField.swift
//  Budgetary
//
//  Created by Phillip Baker on 09/01/2025.
//

import SwiftUI

struct CurrencyTextField: UIViewRepresentable {
    // Local destination type to avoid referencing the generic AssignMoneyView<C>.Destination
    enum Destination: String, Identifiable {
        case moveMoney
        case detail
        var id: String { rawValue }
    }

    @Binding var value: Decimal

    let onEquals: () -> Void
    let onSubmit: () -> Void
    let onCancel: (() -> Void)?
    let onOperation: (AmountOperation) -> Void
    let onTextChanged: ((Decimal) -> Void)?
    let onDeleteWhileEmpty: (() -> Void)?
   
    let textColor: UIColor
    let textStyle: UIFont.TextStyle
    let fontWeight: UIFont.Weight
    let textAlignment: NSTextAlignment
    
    let currencyCode: String
    let primaryIsNegative: Bool
    
    let navigationRowIsPresented: Bool
    let destination: (Destination?) -> Void // Use local Destination type here
    
    init(
        value: Binding<Decimal>,
        onEquals: @escaping () -> Void = {},
        onSubmit: @escaping () -> Void,
        onCancel: (() -> Void)? = nil,
        onOperation: @escaping (AmountOperation) -> Void,
        onTextChanged: ((Decimal) -> Void)?,
        onDeleteWhileEmpty: (() -> Void)? = nil,
        textColor: UIColor = UIColor.label,
        textStyle: UIFont.TextStyle = .largeTitle,
        fontWeight: UIFont.Weight = .semibold,
        textAlignment: NSTextAlignment = .center,
        currencyCode: String = "GBP",
        primaryIsNegative: Bool = false,
        navigationRowIsPresented: Bool = false,
        destination: @escaping (Destination?) -> Void = { _ in }
    ) {
        self._value = value
        self.onEquals = onEquals
        self.onSubmit = onSubmit
        self.onCancel = onCancel
        self.onOperation = onOperation
        self.onTextChanged = onTextChanged
        self.onDeleteWhileEmpty = onDeleteWhileEmpty
        self.textColor = textColor
        self.textStyle = textStyle
        self.fontWeight = fontWeight
        self.textAlignment = textAlignment
        self.currencyCode = currencyCode
        self.primaryIsNegative = primaryIsNegative
        self.navigationRowIsPresented = navigationRowIsPresented
        self.destination = destination
    }

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
        textField.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        let keyboardVC = UIHostingController(
            rootView: AssignMoneyKeyboard(
                onSubmitKeyTapped: context.coordinator.submitKeyTapped,
                onCancelKeyTapped: onCancel,
                onEqualsKeyTapped: onEquals,
                onDeleteKeyTapped: context.coordinator.deleteKeyTapped,
                onNumberKeyTapped: context.coordinator.insert,
                onOperationKeyTapped: onOperation,
                destination: destination,
                navigationRowIsPresented: navigationRowIsPresented
            )
        )
        
        keyboardVC.view.translatesAutoresizingMaskIntoConstraints = false
        keyboardVC.view.backgroundColor = UIColor.clear
        context.coordinator.hostingController = keyboardVC
        textField.inputView = keyboardVC.view

        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.textColor = textColor
        
        // Convert Decimal to Digit Buffer (String)
        let magnitude = abs(value)
        let scaled = magnitude * 100
        let wholeNumber = NSDecimalNumber(decimal: scaled).stringValue
        
        if context.coordinator.digitBuffer != wholeNumber {
            context.coordinator.digitBuffer = wholeNumber
        }

        let formatted = CurrencyTextField.formattedText(value: value, currencyCode: currencyCode, primaryIsNegative: primaryIsNegative)
        
        if uiView.text != formatted {
            uiView.text = formatted
        }
    }
    
    static func formattedText(value: Decimal, currencyCode: String, primaryIsNegative: Bool) -> String {
        let formatted = value.formatted(.currency(code: currencyCode))
        return primaryIsNegative ? "-" + formatted : formatted
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(
            value: $value,
            onSubmit: onSubmit,
            onTextChanged: onTextChanged,
            onDeleteWhileEmpty: onDeleteWhileEmpty
        )
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var value: Decimal
        let onSubmit: () -> Void
        let onTextChanged: ((Decimal) -> Void)?
        let onDeleteWhileEmpty: (() -> Void)?
        
        weak var textField: UITextField?
        weak var hostingController: UIHostingController<AssignMoneyKeyboard>?
        
        var digitBuffer: String = "0"

        init(
            value: Binding<Decimal>,
            onSubmit: @escaping () -> Void,
            onTextChanged: ((Decimal) -> Void)?,
            onDeleteWhileEmpty: (() -> Void)? = nil
        ) {
            self._value = value
            self.onSubmit = onSubmit
            self.onTextChanged = onTextChanged
            self.onDeleteWhileEmpty = onDeleteWhileEmpty
        }
        
        func insert(_ newText: String) {
            let filtered = newText.filter(\.isWholeNumber)
            guard !filtered.isEmpty else { return }

            if digitBuffer == "0" {
                digitBuffer = filtered
            } else {
                digitBuffer += filtered
            }

            updateValueFromBuffer()
        }


        @objc func textIsChanging(_ textField: UITextField) {
            onTextChanged?(value)
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            DispatchQueue.main.async {
                textField.selectedTextRange = textField.textRange(from: textField.endOfDocument, to: textField.endOfDocument)
            }
        }
        
        func deleteKeyTapped() {
            if digitBuffer == "0" {
                onDeleteWhileEmpty?()
                return
            }
            
            digitBuffer = String(digitBuffer.dropLast())
            
            if digitBuffer.isEmpty {
                digitBuffer = "0"
            }
            updateValueFromBuffer()
        }
        
        private func updateValueFromBuffer() {
            let whole = Decimal(string: digitBuffer) ?? 0
            let decimal = whole / pow(10, 2)
            value = decimal
            onTextChanged?(decimal)
        }

        func submitKeyTapped() {
            guard let textField else { return }
            if let delegate = textField.delegate {
                _ = delegate.textFieldShouldReturn?(textField)
            }
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if string.isEmpty {
                deleteKeyTapped()
            } else {
                insert(string)
            }
            return false
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            onSubmit()
            return true
        }
    }
}
