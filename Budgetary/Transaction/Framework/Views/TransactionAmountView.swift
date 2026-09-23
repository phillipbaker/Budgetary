//
//  TransactionAmountView.swift
//  Budgetary
//
//  Created by Phillip Baker on 18/05/2025.
//

import SwiftUI

struct TransactionAmountView: View {
    @Bindable var model: TransactionAmountViewModel
    @FocusState var focusedField: TransactionView.FocusedField?
    
    let onAppear: () -> Void

    var body: some View {
        HStack(spacing: 8) {
            CurrencyTextField(
                value: $model.primary,
                onSubmit: model.onSubmit,
                onOperation: model.onOperation,
                onTextChanged: model.updatePrimary,
                textColor: model.transactionType.uiColor,
                primaryIsNegative: model.primaryIsNegative
            )
            .focused($focusedField, equals: .primaryOperand)
            
            if !model.operationString.isEmpty {
                HStack(spacing: 8) {
                    Text(model.operationString)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundStyle(model.transactionType.color)
                    CurrencyTextField(
                        value: $model.secondary,
                        onEquals: model.onEquals,
                        onSubmit: model.onSubmit,
                        onOperation: model.onOperation,
                        onTextChanged: model.updateSecondary,
                        onDeleteWhileEmpty: model.onDeleteWhileEmpty,
                        textColor: model.transactionType.uiColor
                    )
                    .focused($focusedField, equals: .secondaryOperand)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .onAppear {
            onAppear()
        }
    }
}

#Preview {
    TransactionAmountView(model: .init(), onAppear: {})
}
