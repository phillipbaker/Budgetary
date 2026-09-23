//
//  AccountsPresentationMapper.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/05/2025.
//

import Foundation
import SwiftUI

public final class AccountsPresentationMapper {
    func mapViewState(from accountData: [AccountData], and sheet: Sheet?) -> AccountsPresentationState {
        let accounts = accountData.map { account in
            return TransactionPresentationMapper.map(account: account)
        }
        let groupedAccounts = Dictionary(grouping: accounts, by: { $0.accountType.group })
        return AccountsPresentationState(accounts: groupedAccounts, sheet: sheet)
    }
    
    func map(accounts: [AccountData]) -> [TransactionAccountPresentation] {
        return accounts.map { account in
            map(account: account)
        }
    }
    
    func map(account: AccountData) -> TransactionAccountPresentation {
        return TransactionAccountPresentation(
            id: ID<TransactionAccountPresentation>(account.id),
            name: account.name
        )
    }
        
    
//    func map(accounts: [BudgetAccount]) -> [BudgetAccountGroupPresentation : [BudgetAccountPresentation]] {
//        let accounts = accounts.map { account in
//            return TransactionPresentationMapper.map(account: account)
//        }
//        return Dictionary(grouping: accounts, by: { $0.accountType.group })
//    }
    
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

