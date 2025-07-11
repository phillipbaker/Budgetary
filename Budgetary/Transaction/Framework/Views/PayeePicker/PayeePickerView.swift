//
//  PayeePickerView.swift
//  Budgetary
//
//  Created by Phillip Baker on 09/05/2025.
//

import SwiftUI

struct PayeePickerView: View {
    @Binding var searchText: String
    @FocusState var focused: Bool

    let intent: (PayeePickerIntent) -> Void
    let payeeNames: [PayeeName]
    let selectPayee: (PayeePresentation) -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            SearchField(
                title: "Find or add a payee",
                searchText: $searchText,
                focused: _focused
            )
            .background(Color(.systemGroupedBackground))
            
            List {
                if !searchText.isEmpty {
                    NewPayeeButton(
                        action: { intent(.newPayee(searchText)) },
                        searchText: searchText
                    )
                    
                    ForEach(filteredPayees) { payee in
                        PayeeNameRow(
                            action: selectPayee,
                            payee: payee
                        )
                    }
                } else {
                    ForEach(payeeNames) { payeeName in
                        Section {
                            ForEach(payeeName.payees) { payee in
                                PayeeNameRow(
                                    action: selectPayee,
                                    payee: payee
                                )
                            }
                        } header: {
                            Text(payeeName.letter)
                        }
                    }
                }
            }
            .scrollDismissesKeyboard(.immediately)
            
            var filteredPayees: [PayeePresentation] {
                guard !searchText.isEmpty else { return [] }
                
                return payeeNames // [PayeeName]
                    .flatMap { $0.payees } // [PayeePresentation]
                    .filter { $0.name.lowercased().contains(searchText.lowercased()) } // [PayeePresentation]
                    .sorted { $0.name.rankedAgainst(text: searchText) < $1.name.rankedAgainst(text: searchText) }
            }
        }
    }
}

#Preview {
    PayeePickerView(
        searchText: .constant(""),
        intent: { _ in },
        payeeNames: [],
        selectPayee: { _ in }
    )
}
