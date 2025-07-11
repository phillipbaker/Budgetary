//
//  AccountsPresentationMapper.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/05/2025.
//

import Foundation
import SwiftUI

public final class AccountsPresentationMapper {
    func map(accounts: [BudgetAccount]) -> [BudgetAccountPresentation] {
        return accounts.map { account in
            TransactionPresentationMapper.map(account: account)
        }
    }
    
    func map(accounts: [TransactionAccount]) -> [TransactionAccountPresentation] {
        accounts.map { account in
            return TransactionAccountPresentation(id: account.id, name: account.name)
        }
    }
}

extension Date {
    func startOfDay() -> Date {
        Calendar.current.startOfDay(for: self)
    }
}
