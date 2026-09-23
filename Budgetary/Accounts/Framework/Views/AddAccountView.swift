//
//  AddAccountView.swift
//  Budgetary
//
//  Created by Phillip Baker on 29/11/2025.
//

import Factory
import SwiftUI

struct AddAccountView: View {
    let viewModel: AddAccountViewModel = Container.shared.addAccountViewModel()
    
    @State private var name: String = ""
    @State private var accountType: BudgetAccountTypePresentation? = nil
    @State private var startingBalance: String = ""
    @State private var accountTypePopoverIsPresented: Bool = false
    
    @FocusState private var focusedField: FocusedField?
    
    enum FocusedField {
        case name
        case startingBalance
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Account name", text: $name)
                        .focused($focusedField, equals: .name)
                } header: {
                    Text("Give this account a name")
                }
                
                Section {
                    NavigationLink {
                        AccountTypeView(accountType: $accountType)
                    } label: {
                        Text(accountType?.name ?? "Account type")
                    }
                } header: {
                    Text("What type of account are you adding?")
                }
                
                // TODO: Make this field currency specific based on currency setting
                // TODO: Use custom keyboardand right align. Use CurrencyText Field here...
                Section {
                    TextField("0.00", text: $startingBalance)
                        .focused($focusedField, equals: .startingBalance)
                } header: {
                    Text("What is your current account balance?")
                }
            }
            .navigationTitle("Add Account")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Button(role: .cancel) {
                        viewModel.handle(action: .addAccountCancelButtonTapped)
                    }
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Button(role: .confirm) {
                        viewModel.handle(action: .addAccountSaveButtonTapped(name: name, accountType: accountType, startingBalance: startingBalance))
                    }
                    .disabled(formIsIncomplete)
                }
            }
        }
        .onAppear {
            focusedField = .name
        }
    }
    
    private var formIsIncomplete: Bool {
        return name.isEmpty ||
        startingBalance.isEmpty ||
        accountType == nil
    }
}

#Preview {
    NavigationStack {
        AddAccountView()
            .navigationTitle("Add Account")
            .navigationBarTitleDisplayMode(.inline)
    }
}
