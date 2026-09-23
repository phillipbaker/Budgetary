//
//  AddAccountViewModel.swift
//  Budgetary
//
//  Created by Phillip Baker on 29/01/2026.
//

import Factory
import SwiftUI

@MainActor
@Observable
final public class AddAccountViewModel {
    @ObservationIgnored private let store: AppStore
    @ObservationIgnored private let mapper: BudgetAccountsMapper
    
    var viewState: AddAccountViewState
    
    init(
        store: AppStore = Container.shared.appStore(),
        mapper: BudgetAccountsMapper = Container.shared.budgetAccountsMapper(),
        viewState: AddAccountViewState = .notLoaded
    ) {
        self.store = store
        self.mapper = mapper
        self.viewState = viewState
    }
    
    func handle(action: AddAccountAction) {
        switch action {
        case .addAccountCancelButtonTapped:
            store.dispatch(.addAccountSheetDismissed)
        case .addAccountSaveButtonTapped( let name, let accountType, let startingBalance):
            guard let accountType else {
                self.viewState = .error(.unknownAccountType)
                return
            }
            guard let startingBalance = startingBalance.decimalValue else {
                self.viewState = .error(.invalidStartingBalance)
                return
            }
            store.dispatch(.addAccountRequested(name: name, accountType: mapper.map(accountType: accountType), startingBalance: startingBalance))
        }
    }
}
