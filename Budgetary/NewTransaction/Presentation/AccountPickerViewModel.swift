//
//  AccountPickerViewModel.swift
//  Budgetary
//
//  Created by Phillip Baker on 13/05/2025.
//

import Factory
import SwiftUI

@Observable
final class AccountPickerViewModel {
    @ObservationIgnored private let getAccountsUseCase: GetAccountsUseCase = Container.shared.getAccountsUseCase()
    @ObservationIgnored private let stateMapper: AccountsStateMapper = Container.shared.accountsStateMapper()
    
    var state: AccountsState
    
    init(state: AccountsState = .loading) {
        self.state = state
    }
    
    @MainActor
    func handle(intent: AccountsIntent) {
        Task {
            switch intent {
            case .getAccounts:
                await self.getAccounts()
            }
        }
    }
    
    private func getAccounts() async {
        let accounts = await getAccountsUseCase.accounts()
        self.state = stateMapper.map(accounts: accounts)
    }
    
}
