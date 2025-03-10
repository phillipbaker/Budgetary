//
//  BudgetaryNumberPad.swift
//  Budgetary
//
//  Created by Phillip Baker on 06/01/2025.
//

import SwiftUI
import SwiftUINavigation

struct BudgetaryNumberPad: View {
    weak var target: (UIKeyInput & UIResponder)?
    
    let cancel: () -> Void
    
    @State var destination: Destination? = nil
    
    @CasePathable
    enum Destination {
        case moveMoney
        case detail
    }
    
    var body: some View {
        Grid(verticalSpacing: 16) {            
            GridRow {
                Button {
                    destination = nil
                } label: {
                    DetailButtonLabel(label: "Assign", systemImage: "banknote")
                }
                
                Button {
                    
                } label: {
                    DetailButtonLabel(label: "Auto-Assign", systemImage: "bolt.fill")
                }
                
                Button {
                    destination = .moveMoney
                } label: {
                    DetailButtonLabel(label: "Move Money", systemImage: "arrowshape.right.fill")
                }
                
                Button {
                    destination = .detail
                } label: {
                    DetailButtonLabel(label: "Details", systemImage: "ellipsis")
                }
            }
            .frame(maxWidth: .infinity)
            
            GridRow {
                Button("7") { insert("7") }
                    .font(.title2)
                    .fontWeight(.medium)
                    .tint(.primary)
                
                Button("8") { insert("8") }
                    .font(.title2)
                    .fontWeight(.medium)
                    .tint(.primary)
                
                Button("9") { insert("9") }
                    .font(.title2)
                    .fontWeight(.medium)
                    .tint(.primary)
                
                Button("-") { insert("-") }
                    .font(.title)
                    .fontWeight(.medium)
            }
            .frame(maxWidth: .infinity)
            
            GridRow {
                Button("4") { insert("4") }
                    .font(.title2)
                    .fontWeight(.medium)
                    .tint(.primary)
                
                Button("5") { insert("5") }
                    .font(.title2)
                    .fontWeight(.medium)
                    .tint(.primary)
                
                Button("6") { insert("6") }
                    .font(.title2)
                    .fontWeight(.medium)
                    .tint(.primary)
                
                Button("+") { insert("+") }
                    .font(.title)
                    .fontWeight(.medium)
            }
            .frame(maxWidth: .infinity)
            
            GridRow {
                Button("1") { insert("1") }
                    .font(.title2)
                    .fontWeight(.medium)
                    .tint(.primary)
                
                Button("2") { insert("2") }
                    .font(.title2)
                    .fontWeight(.medium)
                    .tint(.primary)
                
                Button("3") { insert("3") }
                    .font(.title2)
                    .fontWeight(.medium)
                    .tint(.primary)
                
                Button("=") { }
                    .font(.title)
                    .fontWeight(.medium)
            }
            .frame(maxWidth: .infinity)
            
            GridRow {
                Button {
                    cancel()
                    resignFocus()
                } label: {
                    Image(systemName: "x.circle.fill")
                        .tint(.secondary.opacity(0.8))
                }
                
                Button("0") { insert("0") }
                    .font(.title2)
                    .fontWeight(.medium)
                    .tint(.primary)
                
                Button {
                    deleteButtonTapped()
                } label: {
                    Image(systemName: "delete.left")
                        .tint(.primary)
                }
                
                Button("Done") {
                    guard let textField = target as? UITextField else { return }
                    if let delegate = textField.delegate {
                        _ = delegate.textFieldShouldReturn?(textField)
                    }
                }
                .font(.subheadline)
                .fontWeight(.semibold)
                .buttonStyle(.borderedProminent)
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
        .padding()
        .overlay(
            Rectangle()
                .frame(height: 1) // Border height
                .foregroundColor(Color.gray.opacity(0.25))
                .offset(y: -1),
            alignment: .top
        )
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
