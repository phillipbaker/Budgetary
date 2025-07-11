//
//  TransactionDetailView.swift
//  Budgetary
//
//  Created by Phillip Baker on 03/05/2025.
//

import Factory
import SwiftUI

struct TransactionDetailView: View {
    let viewModel: TransactionDetailViewModel

    @Environment(\.dismiss) var dismiss
    @FocusState var focusedField: TransactionDetailViewModel.FocusedField?
    
    var body: some View {
        @Bindable var viewModel = viewModel
        NavigationStack {
            ScrollViewReader { proxy in
                List {
                    Section {
                        Picker("Transaction Type", selection: $viewModel.transactionType) {
                            Text("- Outflow")
                                .tag(TransactionType.outflow)
                            Text("+ Inflow")
                                .tag(TransactionType.inflow)
                        }
                        .pickerStyle(.segmented)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .disabled(viewModel.transactionTypePickerIsDisabled)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    }
                    
                    Section {
                        TransactionAmountView(
                            localValues: $viewModel.localValues,
                            currencyCode: viewModel.currencyCode,
                            transactionType: $viewModel.transactionType,
                            focusedField: _focusedField,
                            onAppear: { viewModel.onAppear() },
                            onEquals: { viewModel.onEquals() },
                            onSubmit: {
                                focusedField = nil
                                viewModel.onSubmit()
                            },
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
                                viewModel.datePickerButtonTapped()
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
                                        .foregroundStyle(viewModel.datePickerIsPresented ? Color.accentColor : .primary)
                                }
                                .frame(minHeight: 40)
                            }
                            .tint(.primary)
                        }
                        
                        if viewModel.datePickerIsPresented {
                            DatePicker("Transaction Date", selection: $viewModel.date, displayedComponents: [.date])
                                .labelsHidden()
                                .datePickerStyle(.graphical)
                                .id("datePicker")
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
                        .frame(minHeight: 40)
                        
                        HStack(spacing: 12) {
                            Image(systemName: "note.text")
                                .frame(width: 32, height: 32)
                                .symbolVariant(viewModel.memo.isEmpty ? .none : .fill)
                                .foregroundStyle(viewModel.memo.isEmpty ? .secondary : Color.accentColor)
                            TextField("Enter a memo...", text: $viewModel.memo)
                        }
                        .frame(minHeight: 40)
                    }
                    
                    if !viewModel.isNewTransaction {
                        Section {
                            Button("Delete Transaction", role: .destructive) {
                                viewModel.deleteTransactionButtonTapped()
                            }
                            .frame(maxWidth: .infinity)
                            .confirmationDialog(
                                "Are you sure you want to delete this transaction?",
                                isPresented: $viewModel.deleteTransactionConfirmationDialogIsPresented,
                                titleVisibility: .visible
                            ) {
                                Button("Delete Transaction", role: .destructive) {
                                    viewModel.confirmDeleteTransactionButtonTapped(id: viewModel.id)
                                }
                                Button("Cancel", role: .cancel) {
                                    viewModel.cancelDeleteTransactionButtonTapped()
                                }
                            }
                        }
                    }
                }
                .id("list")
                .listStyle(.insetGrouped)
                .contentMargins(.top, 12)
                .onChange(of: viewModel.focusedField) {
                    focusedField = viewModel.focusedField
                }
                .onChange(of: focusedField) {
                    viewModel.focusedField = focusedField
                }
                .onChange(of: viewModel.isCleared) {
                    focusedField = nil
                }
                .onChange(of: viewModel.date) {
                    viewModel.onChangeOfDate()
                }
                .onChange(of: viewModel.datePickerIsPresented) {
                    viewModel.onChangeOfDatePickerIsPresented(proxy: proxy)
                }
                .onChange(of: viewModel.localValues.secondary) {
                    viewModel.onChangeOfSecondaryOperand()
                }
                .onChange(of: viewModel.transactionType) {
                    viewModel.onChangeOfTransactionType()
                }
                .onChange(of: viewModel.destination) { oldValue, _ in
                    viewModel.onChangeOfDestination(from: oldValue)
                }
                .navigationDestination(item: $viewModel.destination) { destination in
                    switch destination {
                    case .payee:
                        PayeePickerRootView(
                            payee: $viewModel.payee,
                            destination: $viewModel.destination
                        )
                    case .category:
                        CategoryPickerRootView(
                            category: $viewModel.category,
                            destination: $viewModel.destination
                        )
                    case .account:
                        AccountPickerView(
                            account: $viewModel.account,
                            destination: $viewModel.destination
                        )
                    }
                }
//                .task {
//                    viewModel.onAppear()
//                }
            }
            .navigationTitle(viewModel.isNewTransaction ? "New Transaction" : "Transaction")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(viewModel.isNewTransaction ? "Add" : "Done") {
                        viewModel.confirmAddTransactionButtonTapped()
                        dismiss()
                    }
                    .fontWeight(.semibold)
                }
            }
        }
    }
}

#Preview {
    TransactionDetailView(viewModel: .init(transaction: nil, isNewTransaction: true))
}
