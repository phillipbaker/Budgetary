//
//  NewTransactionView.swift
//  Budgetary
//
//  Created by Phillip Baker on 03/05/2025.
//

import Factory
import SwiftUI

struct Operands: Equatable {
    var primary: String
    var secondary: String
    var operation: String
}

struct NewTransactionView: View {
    @Environment(\.dismiss) var dismiss
    let viewModel: NewTransactionViewModel = Container.shared.newTransactionViewModel()

    @FocusState var focusedField: NewTransactionViewModel.FocusedField?
    
    var body: some View {
        @Bindable var viewModel = viewModel
        ScrollViewReader { proxy in
            List {
                Section {
                    Picker("Transaction Type", selection: $viewModel.transactionType) {
                        Text("- Outflow")
                            .tag(TransactionType.outflow)
                        Text("+ Inflow")
                            .tag(TransactionType.inflow)
                    }
                    .disabled(viewModel.pickerIsDisabled)
                    .pickerStyle(.segmented)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                
                Section {
                    NewTransactionAmountView(
                        localValues: $viewModel.localValues,
                        currencyCode: viewModel.currencyCode,
                        transactionType: $viewModel.transactionType,
                        focusedField: _focusedField,
                        onEquals: { viewModel.onEquals() },
                        onSubmit: { viewModel.onSubmit() },
                        onOperation: { operation in viewModel.handle(operation: operation) },
                        onPrimaryOperandTextChanged: { newValue in viewModel.onTextChanged(primaryOperand: newValue) },
                        onSecondaryOperandTextChanged: { newValue in viewModel.onTextChanged(secondaryOperand: newValue) }
                    )
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
                .listSectionSpacing(8)
                
                Section {
                    Button {
                        viewModel.payeePickerButtonTapped()
                    } label: {
                        HStack(spacing: 12) {
                            Image(systemName: "arrow.left.arrow.right.square")
                                .frame(width: 32, height: 32)
                                .foregroundStyle(viewModel.payee == nil ? Color.secondary : .accentColor)
                            VStack(alignment: .leading) {
                                Text("Payee")
                                    .font(viewModel.payee == nil ? .body : .caption)
                                    .foregroundStyle(.secondary)
                                if let payee = viewModel.payee {
                                    Text(payee.name)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.secondary)
                                .imageScale(.small)
                                .fontWeight(.semibold)
                                .opacity(0.5)
                        }
                        .frame(minHeight: 40)
                        .tint(.primary)
                    }
                    
                    Button {
                        viewModel.categoryPickerButtonTapped()
                    } label: {
                        HStack(spacing: 12) {
                            Image(systemName: "banknote")
                                .frame(width: 32, height: 32)
                                .foregroundStyle(viewModel.category == nil ? Color.secondary : .accentColor)
                            VStack(alignment: .leading) {
                                Text("Category")
                                    .font(viewModel.category == nil ? .body : .caption)
                                    .foregroundStyle(.secondary)
                                if let category = viewModel.category {
                                    Text(category.name)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.secondary)
                                .imageScale(.small)
                                .fontWeight(.semibold)
                                .opacity(0.5)
                        }
                        .frame(minHeight: 40)
                        .tint(.primary)
                    }
                    Button {
                        viewModel.accountPickerButtonTapped()
                    } label: {
                        HStack(spacing: 12) {
                            Image(systemName: "building.columns")
                                .frame(width: 32, height: 32)
                                .foregroundStyle(viewModel.account == nil ? Color.secondary : .accentColor)
                            VStack(alignment: .leading) {
                                Text("Account")
                                    .font(viewModel.account == nil ? .body : .caption)
                                    .foregroundStyle(.secondary)
                                if let account = viewModel.account {
                                    Text(account.name)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.secondary)
                                .imageScale(.small)
                                .fontWeight(.semibold)
                                .opacity(0.5)
                        }
                        .frame(minHeight: 40)
                        .tint(.primary)
                    }
                    
                    Button {
                        withAnimation {
                            viewModel.showingDatePicker.toggle()
                        }
                    } label: {
                        HStack(spacing: 12) {
                            Image(systemName: "calendar")
                                .frame(width: 32, height: 32)
                                .foregroundStyle(Color.accentColor)
                            VStack(alignment: .leading) {
                                Text("Date")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                Text(viewModel.date.formatted(.dateTime.day().month().year()))
                                    .foregroundStyle(viewModel.showingDatePicker ? Color.accentColor : .primary)
                            }
                            .frame(minHeight: 40)
                            .id("dateRow")
                        }
                        .tint(.primary)
                    }
                    
                    if viewModel.showingDatePicker {
                        DatePicker("Transaction Date", selection: $viewModel.date, displayedComponents: [.date])
                            .labelsHidden()
                            .datePickerStyle(.graphical)
                        //                            .transition(.move(edge: .bottom))
                    }
                }
                
                Section {
                    HStack(spacing: 12) {
                        Image(systemName: "c.circle")
                            .frame(width: 32, height: 32)
                            .symbolVariant(viewModel.isCleared ? .fill : .none)
                            .foregroundStyle(viewModel.isCleared ? Color.accentColor : .secondary)
                        Toggle("Cleared", isOn: $viewModel.isCleared)
                    }
                }
                
                Section {
                    Button {
                        withAnimation {
                            focusedField = nil
                            // If there are primary and secondary values, apply operation
                            if !viewModel.localValues.operation.isEmpty {
                                viewModel.applyOperation()
                            }
                            viewModel.handle(intent: .addTransaction)
                        }
                        dismiss() // This should happen in my managed navigation state
                    } label: {
                        Text("Save")
                            .frame(minHeight: 32)
                            .frame(maxWidth: .infinity)
                    }
                    .font(.headline)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .listRowBackground(Color.clear)
                    .buttonStyle(.borderedProminent)
                    .id("saveButton")
                }
            }
            .listStyle(.insetGrouped)
            .contentMargins(.top, 12)
            .onChange(of: viewModel.focusedField) {
                focusedField = viewModel.focusedField
            }
            .onChange(of: focusedField) {
                viewModel.focusedField = focusedField
            }
            .onChange(of: viewModel.date) {
                withAnimation {
                    viewModel.showingDatePicker = false
                }
            }
            .onChange(of: viewModel.showingDatePicker) {
                withAnimation {
                    if viewModel.showingDatePicker == true {
                        proxy.scrollTo("saveButton", anchor: .bottom)
                        //                    } else {
                        //                        proxy.scrollTo("dateRow", anchor: .top)
                    }
                }
            }
            .onChange(of: viewModel.localValues.secondary) {
                if abs(viewModel.localValues.secondary.decimalValue) > abs(viewModel.localValues.primary.decimalValue) {
                    if !viewModel.pickerIsDisabled { viewModel.pickerIsDisabled = true }
                } else {
                    if viewModel.pickerIsDisabled { viewModel.pickerIsDisabled = false }
                }
                
                if viewModel.transactionType == .inflow {
                    if viewModel.applyOperation(to: viewModel.localValues.primary.decimalValue, and: viewModel.localValues.secondary.decimalValue) < 0 {
                        viewModel.transactionType = .outflow
                    }
                } else {
                    // viewModel.transactionType == .outflow
                    if viewModel.applyOperation(to: viewModel.localValues.primary.decimalValue, and: viewModel.localValues.secondary.decimalValue) > 0 {
                        viewModel.transactionType = .inflow
                    }
                }
            }
            .onChange(of: viewModel.transactionType) {
                switch viewModel.transactionType {
                case .inflow:
                    if viewModel.localValues.operation.isEmpty || abs(viewModel.localValues.primary.decimalValue) > abs(viewModel.localValues.secondary.decimalValue), viewModel.localValues.primary.first == "-" {
                        viewModel.localValues.primary.remove(at: viewModel.localValues.primary.startIndex)
                    }
                case .outflow:
                    if viewModel.localValues.operation.isEmpty || abs(viewModel.localValues.primary.decimalValue) > abs(viewModel.localValues.secondary.decimalValue), viewModel.localValues.primary.first != "-" {
                        viewModel.localValues.primary.insert("-", at: viewModel.localValues.primary.startIndex)
                    }
                }
            }
            .navigationDestination(item: $viewModel.destination) { destination in
                switch destination {
                case .payee:
                    PayeePickerView(payee: $viewModel.payee, destination: $viewModel.destination)
                case .category:
                    CategoryPickerView(category: $viewModel.category, destination: $viewModel.destination)
                case .account:
                    AccountPickerView(account: $viewModel.account, destination: $viewModel.destination)
                }
            }
        }
        .onAppear {
            if viewModel.isFirstLaunch {
                focusedField = .primaryOperand
                viewModel.isFirstLaunch = false
            }
        }
        .onChange(of: viewModel.destination) { oldValue, newValue in
            if oldValue == nil {
                focusedField = nil
                if viewModel.isFirstLaunch != false { viewModel.isFirstLaunch = false }
            }
        }
    }
}

#Preview {
    NewTransactionView()
}
