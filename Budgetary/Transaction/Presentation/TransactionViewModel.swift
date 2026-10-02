//
//  TransactionViewModel.swift
//  Budgetary
//
//  Created by Phillip Baker on 21/05/2025.
//

import Factory
import SwiftUI
import SwiftUINavigation

@MainActor
@Observable
final class TransactionViewModel {

    // MARK: - Stored State

    @ObservationIgnored private let store: AppStore
    @ObservationIgnored private var observationTask: Task<Void, Never>?

    var viewState: TransactionViewState = .notLoaded

    /// The transaction being authored or edited.
    var draft: TransactionDraft = TransactionDraft()
    private var draftInitialized = false
    
    @CasePathable
    enum Destination: Identifiable {
        case payeePicker
        case categoryPicker
        case accountPicker
        
        var id: String {
            switch self {
            case .payeePicker:
                return "payeePicker"
            case .categoryPicker:
                return "categoryPicker"
            case .accountPicker:
                return "accountPicker"
            }
        }
    }
    
    var destination: Destination? = nil

    // MARK: - Convenience

    /// Non-nil only while `viewState == .loaded`.
    /// Safe to force-unwrap from `TransactionView` because `TransactionRootView` only
    /// renders that view when the state is `.loaded`.
    var loadedState: TransactionPresentationState? {
        guard case .loaded(let state) = viewState else { return nil }
        return state
    }

    // MARK: - Init

    init(
        store: AppStore = Container.shared.appStore(),
        observationTask: Task<Void, Never>? = nil
    ) {
        self.store = store
        self.observationTask = observationTask
        observeStore()
    }

    // MARK: - Handle

    // TODO: TransactionAction.saveTransactionButtonTapped should be updated to carry no associated value — the draft is now owned by this view model. TransactionAction no longer needs selectCategoryButtonTapped,selectPayeeButtonTapped, or selectAccountButtonTapped. Use the direct selectCategory / selectPayee / selectAccount methods below.

    func handle(action: TransactionAction) {
        switch action {
        case .setDraftAmount(let amount):
            draft.amount = amount

        case .setDraftTransactionType(let type):
            draft.amount.type = type

        case .cancelButtonTapped:
            store.dispatch(.sheetDismissed) // TODO: This I think duplicates system but still need a cancel button so figure out

        case .saveTransactionButtonTapped:
            saveDraft()

        case .confirmDeleteButtonTapped(let id):
            store.dispatch(.deleteTransactionRequested(id))

        case .payeePickerButtonTapped:
            destination = .payeePicker
            store.dispatch(.payeeDataLoadRequested)

        case .newPayeeButtonTapped(let name):
            store.dispatch(.createNewPayeeRequested(name))

        case .categoryPickerButtonTapped:
            destination = .categoryPicker
            store.dispatch(.loadBudgetRequested)

        case .accountPickerButtonTapped:
            destination = .accountPicker
            store.dispatch(.budgetAccountsDataLoadRequested)
        }
    }

    // MARK: - Draft Mutations

    func selectCategory(_ category: TransactionCategoryPresentation) {
        draft.category = category
        destination = nil
    }

    func selectPayee(_ payee: PayeePresentation) {
        draft.payee = payee
        
        if case let .transfer(accountID) = payee.type,
           accountID == ID<BudgetAccountPresentation>(draft.account?.id) {
            draft.account = nil
        }

        destination = nil
    }

    func selectAccount(_ account: TransactionAccountPresentation) {
        draft.account = account
        
        if case let .transfer(accountID) = draft.payee?.type,
           accountID == ID<BudgetAccountPresentation>(account.id) {
            draft.payee = nil
        }
        
        destination = nil
    }

    // MARK: - Store Observation

    private func observeStore() {
        observationTask = Task {
            for await state in store.observe() {
                switch state.transactionState {
                case .notLoaded:
                    self.viewState = .notLoaded
                case .loading:
                    self.viewState = .loading
                case .error(let transactionError):
                    self.viewState = .error(transactionError)
                case .loaded(let transactionData):
                    if !self.draftInitialized {
                        self.draft = TransactionPresentationMapper.map(transactionData: transactionData.transactionToEdit)
                        self.draftInitialized = true
                    }
                    self.viewState = .loaded(
                        TransactionPresentationState(
                            currencyCode: state.currencyCode,
                            isNewTransaction: transactionData.isNewTransaction,
                            transaction: TransactionPresentationMapper.map(transaction: state.transactionState.data?.transactionToEdit)
                        )
                    )
                }
            }
        }
    }
    
    deinit {
        observationTask?.cancel()
    }

    // MARK: - Private

    private func saveDraft() {
        guard let account = draft.account else { return }
        
        let request = SaveTransactionRequest(
            id: ID<BudgetTransaction>(draft.id),
            date: draft.date,
            memo: draft.memo,
            amount: TransactionPresentationMapper.map(amountRequest: draft.amount),
            isCleared: draft.isCleared,
            payeeID: ID<Payee>(draft.payee?.id),
            categoryID: ID<TransactionCategory>(draft.category?.id),
            accountID: ID<BudgetAccount>(account.id),
            linkedTransactionID: ID<BudgetTransaction>(draft.linkedTransactionID)
        )
        store.dispatch(.saveTransactionRequested(request))
    }
    
    // MARK: - Mapping
    
    @ObservationIgnored let payeeMapper: PayeePresentationMapper = Container.shared.payeePresentationMapper()
    
    func map(payeePickerState: PayeePickerState) -> PayeesStatePresentation {
        switch payeePickerState {
        case .error:
            return .error
        case .loading:
            return .loading
        case .loaded(let payees):
            return .loaded(payeeMapper.map(payees: payees))
        case .notLoaded:
            return .notLoaded
        }
    }
    
    @ObservationIgnored let accountsMapper: AccountsPresentationMapper = Container.shared.accountsPresentationMapper()
    
    func map(accountPickerState: AccountPickerState) -> AccountPickerStatePresentation {
        switch accountPickerState {
        case .error:
            return .error
        case .loading:
            return .loading
        case .loaded(let accounts):
            return .loaded(accountsMapper.map(accounts: accounts))
        case .notLoaded:
            return .notLoaded
        }
    }
}
