//
//  AccountsViewModel.swift
//  Budgetary
//
//  Created by Phillip Baker on 03/05/2025.
//

import Factory
import SwiftUI

@Observable
final class AccountsViewModel {
    @ObservationIgnored private let stateMapper: AccountsStateMapper = Container.shared.accountsStateMapper()
    @ObservationIgnored private let getAccountsUseCase: GetAccountsUseCase = Container.shared.getAccountsUseCase()
    
    var state: AccountsState
    
    init(state: AccountsState = .loading) {
        self.state = state
    }
    
    @MainActor
    func handle(intent: AccountsIntent) {
        Task {
            switch intent {
            case .getAccounts:
                await getAccounts()
            }
        }
    }
    
    // need some task mangement here? Don’t want to add a new listener every time this is called...
    private func getAccounts() async {
        self.state = stateMapper.map(accounts: [BudgetAccount.hsbcChecking])
    }
}
