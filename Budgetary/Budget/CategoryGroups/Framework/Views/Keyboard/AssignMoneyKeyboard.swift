//
//  AssignMoneyKeyboard.swift
//  Budgetary
//
//  Created by Phillip Baker on 06/01/2025.
//

import SwiftUI

struct AssignMoneyKeyboard: View {
    @Environment(\.colorScheme) var colorScheme

    let onSubmitKeyTapped: () -> Void
    let onCancelKeyTapped: () -> Void
    let onEqualsKeyTapped: () -> Void
    let onDeleteKeyTapped: () -> Void
    let onNumberKeyTapped: (String) -> Void
    let onOperationKeyTapped: (String) -> Void

    let destination: (AssignMoneyView.Destination?) -> Void
    
    let cancelButtonIsPresented: Bool
    let navigationRowIsPresented: Bool

    var body: some View {
        VStack {
            if navigationRowIsPresented {
                KeyboardAccessoryView(destination: destination)
            }
            Grid(verticalSpacing: 24) {
                Grid(verticalSpacing: 8) {
                    GridRow {
                        NumberButton(number: "7", insert: onNumberKeyTapped)
                        NumberButton(number: "8", insert: onNumberKeyTapped)
                        NumberButton(number: "9", insert: onNumberKeyTapped)
                        OperationButton(title: "-", image: "minus", action: onOperationKeyTapped)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    GridRow {
                        NumberButton(number: "4", insert: onNumberKeyTapped)
                        NumberButton(number: "5", insert: onNumberKeyTapped)
                        NumberButton(number: "6", insert: onNumberKeyTapped)
                        OperationButton(title: "+", image: "plus", action: onOperationKeyTapped)
                    }
                    .frame(maxWidth: .infinity)
                    
                    GridRow {
                        NumberButton(number: "1", insert: onNumberKeyTapped)
                        NumberButton(number: "2", insert: onNumberKeyTapped)
                        NumberButton(number: "3", insert: onNumberKeyTapped)
                        EqualsButton(action: onEqualsKeyTapped)
                    }
                    .frame(maxWidth: .infinity)
                    
                    GridRow {
                        if cancelButtonIsPresented {
                            CancelButton(onCancel: onCancelKeyTapped)
                        } else {
                            Color.clear
                                .gridCellUnsizedAxes([.horizontal, .vertical])
                        }
                        NumberButton(number: "0", insert: onNumberKeyTapped)
                        DeleteButton(onDelete: onDeleteKeyTapped)
                        DoneButton(onSubmit: onSubmitKeyTapped)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding()
    }
}
