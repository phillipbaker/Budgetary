//
//  BudgetaryNumberPad.swift
//  Budgetary
//
//  Created by Phillip Baker on 06/01/2025.
//

import SwiftUI
import SwiftUINavigation

struct BudgetaryNumberPad: View {
    @Environment(\.colorScheme) var colorScheme
    weak var target: (UIKeyInput & UIResponder)?
    
    let onCancel: () -> Void
    let onEquals: () -> Void
    let onOperation: (String) -> Void
    
    @State var destination: Destination? = nil
    
    @CasePathable
    enum Destination {
        case moveMoney
        case detail
    }
    
    var body: some View {
        Grid(verticalSpacing: 24) {
            GridRow {
                KeypadNavigationButton(title: "Assign", image: "banknote", action: { destination = nil }, tint: Color.accentColor)
                KeypadNavigationButton(title: "Auto-Assign", image: "bolt.fill", action: {}, tint: .secondary)
                KeypadNavigationButton(title: "Move Money", image: "arrowshape.right.fill", action: { destination = .moveMoney }, tint: .secondary)
                KeypadNavigationButton(title: "Details", image: "ellipsis", action: { destination = .detail }, tint: .secondary)
            }
            .frame(maxWidth: .infinity)
            
            GridRow {
                NumberButton(number: "7", insert: insert)
                NumberButton(number: "8", insert: insert)
                NumberButton(number: "9", insert: insert)
                OperationButton(title: "-", image: "minus", action: { operation in onOperation(operation) })
            }
            .frame(maxWidth: .infinity)
            
            GridRow {
                NumberButton(number: "4", insert: insert)
                NumberButton(number: "5", insert: insert)
                NumberButton(number: "6", insert: insert)
                OperationButton(title: "+", image: "plus", action: { operation in onOperation(operation) })
            }
            .frame(maxWidth: .infinity)
            
            GridRow {
                NumberButton(number: "1", insert: insert)
                NumberButton(number: "2", insert: insert)
                NumberButton(number: "3", insert: insert)
                EqualsButton(action: onEquals)
            }
            .frame(maxWidth: .infinity)
            
            GridRow {
                CancelButton(onCancel: onCancel)
                NumberButton(number: "0", insert: insert)
                DeleteButton(onDelete: deleteButtonTapped)
                DoneButton(onSubmit: doneButtonTapped)
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(8)
        .background(colorScheme == .light ? .white : Color(.tertiarySystemBackground))
        .overlay(alignment: .top) {
            Rectangle()
                .frame(height: 1) // Border height
                .foregroundColor(Color.secondary.opacity(0.25))
                .offset(y: -1)
        }
        .sheet(isPresented: Binding($destination.moveMoney), onDismiss: { resignFocus() }) {
            MoveMoneyView()
        }
        .sheet(isPresented: Binding($destination.detail), onDismiss: { resignFocus() }) {
            CategoryDetailView()
        }
    }
    
    func resignFocus() {
        DispatchQueue.main.async {
            target?.resignFirstResponder()
        }
    }
    
    private func insert(_ text: String) {
        if let targetTextInput = target as? UITextInput {
            let numberPressed = text
            if numberPressed.count > 0 {
                let selectedTextRange = targetTextInput.selectedTextRange
                if let selectedTextRange = selectedTextRange {
                    textInput(targetTextInput, replaceTextAt: selectedTextRange, with: numberPressed)
                }
            }
        }
    }
    
    private func textInput(_ textInput: UITextInput?, shouldChangeCharactersIn range: NSRange, with string: String?) -> Bool {
        if let textInput = textInput {
            if textInput is UITextField {
                let textField = textInput as? UITextField
                if textField?.delegate?.responds(to: #selector(UITextFieldDelegate.textField(_:shouldChangeCharactersIn:replacementString:))) ?? false {
                    if let textField = textField {
                        if textField.delegate?.textField?(
                            textField,
                            shouldChangeCharactersIn: range,
                            replacementString: string ?? "") ?? false {
                            return true
                        }
                    }
                } else {
                    // Delegate does not respond, so default to YES
                    return true
                }
            } else if textInput is UITextView {
                let textView = textInput as? UITextView
                if textView?.delegate?.responds(to: #selector(UITextViewDelegate.textView(_:shouldChangeTextIn:replacementText:))) ?? false {
                    if let textView = textView {
                        if textView.delegate?.textView?(
                            textView,
                            shouldChangeTextIn: range,
                            replacementText: string ?? "") ?? false {
                            return true
                        }
                    }
                } else {
                    // Delegate does not respond, so default to YES
                    return true
                }
            }
        }
        return false
    }
    
    private func textInput(_ textInput: UITextInput?, replaceTextAt textRange: UITextRange?, with string: String?) {
        if let textInput = textInput {
            if let textRange = textRange {
                // Calculate the NSRange for the textInput text in the UITextRange textRange:
                let startPos = textInput.offset(
                    from: textInput.beginningOfDocument,
                    to: textRange.start)
                let length = textInput.offset(
                    from: textRange.start,
                    to: textRange.end)
                let selectedRange = NSRange(location: startPos, length: length)
                
                if self.textInput(textInput, shouldChangeCharactersIn: selectedRange, with: string) {
                    // Make the replacement:
                    textInput.replace(textRange, withText: string ?? "")
                }
            }
        }
    }
    
    private func doneButtonTapped() {
        guard let textField = target as? UITextField else { return }
        if let delegate = textField.delegate {
            _ = delegate.textFieldShouldReturn?(textField)
        }
    }
    
    private func deleteButtonTapped() {
        if let targetTextInput = target as? UITextInput {
            let selectedTextRange = targetTextInput.selectedTextRange
            if let selectedTextRange = selectedTextRange {
                // Calculate the selected text to delete
                let startPosition = targetTextInput.position(from: selectedTextRange.start, offset: -1)
                if startPosition == nil {
                    return
                }
                let endPosition = selectedTextRange.end
                var rangeToDelete: UITextRange? = nil
                if let startPosition = startPosition {
                    rangeToDelete = targetTextInput.textRange(
                        from: startPosition,
                        to: endPosition
                    )
                }
                
                textInput(targetTextInput, replaceTextAt: rangeToDelete, with: "")
            }
        }
    }
}

struct KeypadNavigationButton: View {
    let title: String
    let image: String
    let action: () -> Void
    let tint: Color
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: image)
                    .frame(minWidth: 28, minHeight: 20)
                    .font(.title2)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 28)
                    .background(.secondary.opacity(0.16))
                    .tint(tint)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                Text(title)
                    .font(.caption)
                    .fontWeight(.regular)
                    .tint(.secondary)
            }
        }
    }
}

struct OperationButton: View {
    let title: String
    let image: String
    let action: ((String) -> Void)
    @State private var isTapped: Bool = false
    
    var body: some View {
        Button {
            action(title)
            isTapped.toggle()
        } label: {
            Image(systemName: image)
        }
        .font(.title)
        .sensoryFeedback(.impact(weight: .light), trigger: isTapped)
    }
}

struct EqualsButton: View {
    let action: () -> Void
    @State private var isTapped: Bool = false
    
    var body: some View {
        Button {
            action()
            isTapped.toggle()
        } label: {
            Image(systemName: "equal")
        }
        .font(.title)
        .sensoryFeedback(.impact(weight: .light), trigger: isTapped)
    }
}

struct NumberButton: View {
    let number: String
    let insert: ((String) -> Void)
    @State private var isTapped: Bool = false
    
    var body: some View {
        Button(number) {
            insert(number)
            isTapped.toggle()
        }
        .font(.title)
        .tint(.primary)
        .sensoryFeedback(.impact(weight: .light), trigger: isTapped)
    }
}

struct CancelButton: View {
    let onCancel: () -> Void
    @State private var isTapped: Bool = false
    
    var body: some View {
        Button {
            onCancel()
            isTapped.toggle()
        } label: {
            Image(systemName: "x.circle.fill")
                .tint(.secondary.opacity(0.6))
        }
        .font(.title)
        .sensoryFeedback(.impact(weight: .light), trigger: isTapped)
    }
}

struct DeleteButton: View {
    let onDelete: () -> Void
    @State private var isTapped: Bool = false
    
    var body: some View {
        Button {
            onDelete()
            isTapped.toggle()
        } label: {
            Image(systemName: "delete.left")
        }
        .font(.title)
        .sensoryFeedback(.impact(weight: .light), trigger: isTapped)
    }
}

struct DoneButton: View {
    let onSubmit: () -> Void
    @State private var isTapped: Bool = false
    
    var body: some View {
        Button("done") {
            onSubmit()
            isTapped.toggle()
        }
        .font(.body)
        .fontWeight(.semibold)
        .buttonStyle(.borderedProminent)
        .sensoryFeedback(.impact(weight: .light), trigger: isTapped)
    }
}
