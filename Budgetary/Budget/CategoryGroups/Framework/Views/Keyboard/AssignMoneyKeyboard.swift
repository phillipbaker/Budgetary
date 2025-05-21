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
    
    let isShowingCancel: Bool
    let isShowingNavigationRow: Bool

    var body: some View {
        Grid(verticalSpacing: 24) {
            if isShowingNavigationRow {
                GridRow {
                    KeypadNavigationButton(
                        title: "Assign",
                        image: "banknote",
                        action: { destination(nil) },
                        tint: Color.accentColor
                    )
                    KeypadNavigationButton(
                        title: "Auto-Assign",
                        image: "bolt.fill",
                        action: {},
                        tint: .secondary
                    )
                    KeypadNavigationButton(
                        title: "Move Money",
                        image: "arrowshape.right.fill",
                        action: { destination(.moveMoney) },
                        tint: .secondary
                    )
                    KeypadNavigationButton(
                        title: "Details",
                        image: "ellipsis",
                        action: { destination(.detail) },
                        tint: .secondary
                    )
                }
                .frame(maxWidth: .infinity)
            }

            GridRow {
                NumberButton(number: "7", insert: onNumberKeyTapped)
                NumberButton(number: "8", insert: onNumberKeyTapped)
                NumberButton(number: "9", insert: onNumberKeyTapped)
                OperationButton(title: "-", image: "minus", action: onOperationKeyTapped)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, isShowingNavigationRow ? 0 : 16)
            
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
                if isShowingCancel {
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(8)
        .background(colorScheme == .light ? .white : Color(.tertiarySystemBackground))
        .overlay(alignment: .top) {
            Rectangle()
                .frame(height: 1) // Border height
                .foregroundColor(Color.secondary.opacity(0.25))
                .offset(y: -1)
        }
    }
}
