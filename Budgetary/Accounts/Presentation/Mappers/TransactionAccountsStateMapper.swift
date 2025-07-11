//
//  TransactionAccountsStateMapper.swift
//  Budgetary
//
//  Created by Phillip Baker on 25/05/2025.
//

import Factory

public final class TransactionAccountsStateMapper {
    let mapper: AccountsPresentationMapper = Container.shared.accountsPresentationMapper()

    func map(accounts: [TransactionAccount]) -> TransactionAccountsState {
        return .success(mapper.map(accounts: accounts))
    }
}
