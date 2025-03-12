//
//  AssignMoneyView.swift
//  Budgetary
//
//  Created by Phillip Baker on 28/01/2025.
//

import SwiftUI

struct AssignMoneyView: View {
    let monthYear: MonthYear
    let currencyCode: String
    let onTextChanged: ((String) -> Void)?
    let onUpdateAssignedAmount: () -> Void
    
    @Binding var assignedValue: String
    @FocusState var isTextFieldFocused: Bool
    
    var body: some View {
        Text("£9,999,999.99")
            .foregroundStyle(.red)
            .hidden()
            .overlay(alignment: .trailing) {
                VStack {
                    CurrencyTextField(
                        text: $assignedValue,
                        currencyCode: currencyCode,
                        onTextChanged: onTextChanged,
                        onUpdateAssignedAmount: onUpdateAssignedAmount
                    )
                    .id(monthYear)
                    .offset(x: -4)
                    .fontWeight(.semibold)
                    .focused($isTextFieldFocused)
                }
            }
            .frame(minWidth: 112, alignment: .trailing)
            .font(.subheadline)
            .fontWeight(.semibold)
            .padding(.vertical, 2)
    }
}
