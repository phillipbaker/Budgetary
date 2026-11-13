//
//  AccountPickerView.swift
//  Budgetary
//
//  Created by Phillip Baker on 10/05/2025.
//

import SwiftUI

struct AccountPickerView: View {
    @Bindable var model: AccountPickerViewModel
    
    var body: some View {
        List {
            ForEach(model.accountRows) { row in
                Button {
                    model.selectAccountButtonTapped(row.account)
                } label: {
                    HStack {
                        Image(systemName: "checkmark" )
                            .opacity(row.account == model.selectedAccount ? 1 : 0)
                        Text(row.account.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(row.balance)
                            .foregroundStyle(row.balanceStyle.color)
                            .fontWeight(.semibold)
                    }
                    .font(.subheadline)
                }
            }
        }
        .contentMargins(.top, 12)
        .navigationTitle("Account")
    }
}

#Preview {
    AccountPickerView(model: .init(onSelect: { _ in }))
}
