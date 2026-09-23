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
            ForEach(model.accounts) { account in
                Button {
                    model.selectAccountButtonTapped(account)
                } label: {
                    HStack {
                        Image(systemName: "checkmark" )
                            .opacity(account == model.selectedAccount ? 1 : 0)
                        Text(account.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .tint(.primary)
                        Text("£999.99")
                            .foregroundStyle(model.foregroundStyle(for: account))
                    }
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
