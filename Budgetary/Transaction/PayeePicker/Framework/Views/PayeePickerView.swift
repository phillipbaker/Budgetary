//
//  PayeePickerView.swift
//  Budgetary
//
//  Created by Phillip Baker on 09/05/2025.
//

import SwiftUI

struct PayeePickerView: View {    
    @Bindable var model: PayeePickerViewModel
    @FocusState var focused: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            SearchField(
                title: "Find or add a payee",
                searchText: $model.searchText,
                focused: _focused
            )
            .background(Color(.systemGroupedBackground))
            
            List {
                if model.searchText.isEmpty {
                    AddItemButton("New Payee") {
                        model.newPayeeButtonTapped()
                    }
                    
                    Section {
                        ForEach(model.transferPayees) { transferPayee in
                            PayeeNameRow(
                                payee: transferPayee,
                                onSelect: model.selectPayeeButtonTapped
                            )
                        }
                    } header: {
                        Text("Payments and Transfers")
                    }
                    
                    ForEach(model.payeeNames) { payeeName in
                        Section {
                            ForEach(payeeName.payees) { payee in
                                PayeeNameRow(
                                    payee: payee,
                                    onSelect: model.selectPayeeButtonTapped
                                )
                            }
                        } header: {
                            Text(payeeName.letter)
                        }
                    }
                } else {
                    ForEach(model.filteredPayees) { payee in
                        PayeeNameRow(
                            payee: payee,
                            onSelect: model.selectPayeeButtonTapped
                        )
                    }
                }
            }
            .scrollDismissesKeyboard(.immediately)
        }
        .contentMargins(.top, 12)
        .navigationTitle("Payee")
    }
}

#Preview {
    PayeePickerView(model: .init(onSelect: { _ in }))
}

