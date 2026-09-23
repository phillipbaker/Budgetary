//
//  AccountsStateMapper.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/05/2025.
//

import Factory

public final class AccountsStateMapper {
    let mapper: AccountsPresentationMapper = Container.shared.accountsPresentationMapper()
    
    func map(appState: AppState) -> AccountsViewState {
        switch appState.accountsState {
        case .notLoaded:
            return .loading // TODO: Not loading state
        case .loading:
            return .loading
        case .error(let accountsError):
            print(accountsError)
            return .error(.unknownError) // TODO: Map AccountsError to AccountsViewStateError
        case .loaded(let accounts):
            return .loaded(mapper.mapViewState(from: accounts, and: appState.sheet))
        }
    }
}
