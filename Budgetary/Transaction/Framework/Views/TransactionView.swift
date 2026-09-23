//
//  TransactionView.swift
//  Budgetary
//
//  Created by Phillip Baker on 03/05/2025.
//

import Factory
import SwiftUI

struct TransactionView: View {
    @Bindable var model: TransactionViewModel
    @State private var amountModel = TransactionAmountViewModel()
    @FocusState private var focusedField: FocusedField?
    
    enum FocusedField {
        case primaryOperand
        case secondaryOperand
    }

    var body: some View {
        if let state = model.loadedState {
            content(state: state)
        }
    }
    
    @ViewBuilder
    private func content(state: TransactionPresentationState) -> some View {
        NavigationStack {
            ScrollViewReader { proxy in
                List {
                    Section {
                        // Transaction Type
                        TransactionTypePickerView(
                            transactionType: syncedTransactionType,
                            transactionTypePickerIsDisabled: amountModel.transactionTypePickerIsDisabled
                        )
                    }
                    
                    Section {
                        // Amount
                        TransactionAmountView(
                            model: amountModel,
                            focusedField: _focusedField,
                            onAppear: { onAppear(state: state) }
                        )
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                    }
                    .listSectionSpacing(8)
                    
                    Section {
                        // Payee
                        TransactionFieldPickerButton(
                            action: { model.handle(action: .payeePickerButtonTapped) },
                            image: "arrow.left.arrow.right.square",
                            label: "Payee",
                            name: model.draft.payee?.name
                        )
                        // Category
                        TransactionFieldPickerButton(
                            action: { model.handle(action: .categoryPickerButtonTapped) },
                            image: "banknote",
                            label: "Category",
                            name: model.draft.category?.name
                        )
                        // Account
                        TransactionFieldPickerButton(
                            action: { model.handle(action: .accountPickerButtonTapped) },
                            image: "building.columns",
                            label: "Account",
                            name: model.draft.account?.name
                        )
                        // DatePicker
                        DatePickerView(
                            action: { amountModel.datePickerButtonTapped() },
                            datePickerIsPresented: amountModel.datePickerIsPresented,
                            date: $model.draft.date
                        )
                    }
                    
                    Section {
                        // isCleared
                        ClearedToggleView(isCleared: $model.draft.isCleared)
                        // Memo
                        TransactionMemoView(memo: $model.draft.memo)
                    }
                    
                    if !state.isNewTransaction {
                        Section {
                            Button("Delete Transaction", role: .destructive) {
                                amountModel.deleteTransactionButtonTapped()
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .confirmationDialog(
                            "Are you sure you want to delete this transaction?",
                            isPresented: $amountModel.deleteTransactionConfirmationDialogIsPresented,
                            titleVisibility: .visible
                        ) {
                            Button("Delete Transaction", role: .destructive) {
                                model.handle(action: .confirmDeleteButtonTapped(model.draft.id))
                                amountModel.confirmDeleteTransactionButtonTapped()
                            }
                            Button(role: .cancel) {
                                amountModel.cancelDeleteButtonTapped()
                            }
                        }
                    }
                }
                .listStyle(.insetGrouped)
                .contentMargins(.top, 0)
                .onChange(of: model.draft.isCleared) {
                    if focusedField != nil {
                        focusedField = nil
                    }
                }
                .onChange(of: model.draft.date) {
                    // When a new date is selected, close the picker
                    withAnimation { amountModel.datePickerIsPresented = false }
                }
                .onChange(of: amountModel.datePickerIsPresented) {
                    withAnimation {
                        if amountModel.datePickerIsPresented {
                            proxy.scrollTo("datePicker", anchor: .bottom)
                        } else {
                            proxy.scrollTo("list", anchor: .top)
                        }
                    }
                }
                .onChange(of: model.destination) { oldValue, _ in
                    if oldValue == nil {
                        if focusedField != nil { focusedField = nil }
                        if amountModel.isFirstLaunch { amountModel.isFirstLaunch = false }
                    }
                }
                .onChange(of: amountModel.focusIntent) { _, newValue in
                    switch newValue {
                    case .primary:
                        focusedField = .primaryOperand
                    case .secondary:
                        focusedField = .secondaryOperand
                    case .none:
                        focusedField = nil
                    }
                }
                .navigationDestination(item: $model.destination) { destination in
                    Group {
                        switch destination {
                        case .payeePicker:
                            PayeePickerRootView(onSelect: model.selectPayee)
                        case .categoryPicker:
                            CategoryPickerRootView(onSelect: model.selectCategory)
                        case .accountPicker:
                            AccountPickerRootView(onSelect: model.selectAccount)
                        }
                    }
                }
                .navigationTitle(state.isNewTransaction ? "New Transaction" : "Transaction")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(role: .cancel) {
                            model.handle(action: .cancelButtonTapped)
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(role: .confirm) {
                            model.handle(action: .setDraftAmount(
                                AmountDraft(
                                    type: amountModel.transactionType,       // sign lives in the type
                                    value: "\(abs(amountModel.result))"      // value is the magnitude
                                )
                            ))
                            model.handle(action: .saveTransactionButtonTapped)
                        }
                        .fontWeight(.semibold)
                        // TODO: Figure out disable button logic for real. When should it be possible to save?
                        .disabled(model.draft.account == nil)
                    }
                }
            }
        }
    }
    
    // MARK: - Private
    
    private func onAppear(state: TransactionPresentationState) {
        if state.isNewTransaction && amountModel.isFirstLaunch {
            if focusedField != .primaryOperand { focusedField = .primaryOperand }
            amountModel.isFirstLaunch = false
        } else {
            if focusedField != nil { focusedField = nil }
        }
    }
    
    /// Bridges the amount calculator's derived transaction type back into the draft.
    /// Lives in the view because it wires two view-layer objects (amountModel and
    /// model.draft) together — no business logic leaks here.
    private var syncedTransactionType: Binding<TransactionTypePresentation> {
        Binding(
            get: { amountModel.transactionType },
            set: { newValue in
                // Update amount model first so UI stays in sync
                amountModel.setTransactionType(to: newValue)
                // Propagate the derived type back into the draft via the view model action
                model.handle(action: .setDraftTransactionType(amountModel.transactionType))
            }
        )
    }
}

#Preview {
    let model = TransactionViewModel()
    TransactionView(model: model)
}
