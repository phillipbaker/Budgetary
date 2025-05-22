//
//  AccountsStateMapper.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/05/2025.
//

import SwiftUI
import Factory

public final class AccountsStateMapper {
    let mapper: AccountsPresentationMapper = Container.shared.accountsPresentationMapper()

    func map(accounts: [BudgetAccount]) -> AccountsState {
        return .success(mapper.map(accounts: accounts))
    }
}
