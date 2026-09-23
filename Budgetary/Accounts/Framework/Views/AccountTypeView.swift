//
//  AccountTypeView.swift
//  Budgetary
//
//  Created by Phillip Baker on 30/11/2025.
//

import SwiftUI

struct AccountTypeView: View {
    @Binding var accountType: BudgetAccountTypePresentation?
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form {
            Section {
                Button {
                    accountType = .cash(.cash)
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "banknote")
                        Text("Cash")
                    }
                }
                
                Button {
                    accountType = .cash(.checking)
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "building.columns")
                        Text("Checking")
                    }
                }
                
                Button {
                    accountType = .cash(.savings)
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "building.columns")
                        Text("Savings")
                    }
                }
            } header: {
                Text("Cash Accounts")
            }
            
            Section {
                Button {
                    accountType = .credit(.creditCard)
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "creditcard")
                        Text("Credit Card")
                    }
                }
            } header: {
                Text("Credit Accounts")
            }
        }
        .navigationTitle(Text("Account Type"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        AccountTypeView(accountType: .constant(.cash(.checking)))
            .navigationTitle(Text("Account Type"))
            .navigationBarTitleDisplayMode(.inline)
    }
}
