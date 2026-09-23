//
//  BudgetStateMapper.swift
//  Budgetary
//
//  Created by Phillip Baker on 02/11/2024.
//

import Factory

public final class BudgetStateMapper {
    let mapper: BudgetPresentationMapper = Container.shared.budgetPresentationMapper()
    
    func map(appState: AppState) throws -> BudgetViewState {
        switch appState.budgetState {
        case .notLoaded:
            return .loading // TODO: Not Loaded State
        case .loading:
            return .loading
        case .error(let error):
            print(error)
            return .error(.unknownError) // TODO: Map together BudgetError and BudgetViewStateError
        case .loaded(let budgetData):
            return (.budget(try mapper.mapViewState(from: budgetData, for: appState.monthYear, and: appState.filter)))
        }
    }
}
