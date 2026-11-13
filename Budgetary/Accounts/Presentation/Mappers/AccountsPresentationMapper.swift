//
//  AccountsPresentationMapper.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/05/2025.
//

import Foundation

public final class AccountsPresentationMapper {
    func mapViewState(from accountData: [AccountData], and sheet: Sheet?) -> AccountsPresentationState {
        let accounts = accountData.map { account in
            return TransactionPresentationMapper.map(account: account)
        }
        let groupedAccounts = Dictionary(grouping: accounts, by: { $0.accountType.group })
        return AccountsPresentationState(accounts: groupedAccounts, sheet: sheet)
    }
    
    func mapRows(accounts: [AccountData]) -> [AccountPickerRowPresentation] {
        accounts.map { account in
            mapRow(account: account)
        }
    }
    
    func mapRow(account: AccountData) -> AccountPickerRowPresentation {
        let balance = account.balance.rounded(scale: 2)
        return AccountPickerRowPresentation(
            account: map(account: account),
            balance: balance.formatted(.currency(code: "GBP")),
            balanceStyle: map(styleFrom: balance)
        )
    }

    func map(styleFrom balance: Decimal) -> BalanceStyle {
        let rounded = balance.rounded(scale: 2)
        if rounded < 0 { return .negative }
        if rounded > 0 { return .positive }
        return .zero
    }

    func map(account: AccountData) -> TransactionAccountPresentation {
        return TransactionAccountPresentation(
            id: ID<TransactionAccountPresentation>(account.id),
            name: account.name
        )
    }
    
    func map(accounts: [TransactionAccount]) -> [TransactionAccountPresentation] {
        accounts.map { account in
            return TransactionAccountPresentation(id: ID<TransactionAccountPresentation>(account.id), name: account.name)
        }
    }
    
    func map(accounts: [TransactionAccountPresentation]) -> [TransactionAccount] {
        accounts.map { account in
            return TransactionAccount(id: ID<TransactionAccount>(account.id), name: account.name)
        }
    }
}

extension Date {
    func startOfDay() -> Date {
        Calendar.current.startOfDay(for: self)
    }
}


public struct AccountsPresentationState: Sendable {
    let accounts: [BudgetAccountGroupPresentation: [BudgetAccountPresentation]]
    let sheet: Sheet?
}
