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
    @ObservationIgnored private let getTransactionAccountsUseCase: GetTransactionAccountsUseCase = Container.shared.getTransactionAccountsUseCase()
    @ObservationIgnored private let stateMapper: TransactionAccountsStateMapper = Container.shared.transactionAccountsStateMapper()
    
    var state: TransactionAccountsState
    
    init(state: TransactionAccountsState = .loading) {
        self.state = state
    }
    
    @MainActor
    func handle(intent: TransactionAccountsIntent) {
        Task {
            switch intent {
            case .getTransactionAccounts:
                await self.getTransactionAccounts()
            }
        }
    }
    
    private func getTransactionAccounts() async {
        let accounts = await getTransactionAccountsUseCase.accounts()
        self.state = stateMapper.map(accounts: accounts)
    }
    
}
