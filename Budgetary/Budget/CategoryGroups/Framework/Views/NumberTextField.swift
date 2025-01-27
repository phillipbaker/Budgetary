//
//  NumberTextField.swift
//  Budgetary
//
//  Created by Phillip Baker on 07/01/2025.
//

import SwiftUI

struct NumberTextField: View {
    @Binding var value: Decimal
    
    var body: some View {
        Text("£9,999,999.99")
            .foregroundStyle(.red)
            .hidden()
            .overlay(alignment: .trailing) {
                TextField("0.00", value: $value, format: .currency(code: "EUR"))
                    .offset(x: -4)
            }
            .frame(minWidth: 112, alignment: .trailing)
            .font(.subheadline)
            .fontWeight(.semibold)
            .padding(.vertical, 2)
    }
}

#Preview {
    NumberTextField(value: .constant(0.0))
}
