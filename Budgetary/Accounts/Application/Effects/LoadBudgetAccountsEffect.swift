//
//  LoadAccountsEffect.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/05/2025.
//

import Factory

@MainActor
struct LoadBudgetAccountsEffect: AppEffect {
    private let store: AppStore
    private let mapper: BudgetAccountsMapper
    private let loadAccountsUseCase: LoadBudgetAccountsUseCase
    
    init(
        store: AppStore = Container.shared.appStore(),
        mapper: BudgetAccountsMapper = Container.shared.budgetAccountsMapper(),
        loadAccountsUseCase: LoadBudgetAccountsUseCase = Container.shared.loadAccountsDataUseCase()
    ) {
        self.store = store
        self.mapper = mapper
        self.loadAccountsUseCase = loadAccountsUseCase
    }
    
    func run() async {
        let accounts = await loadAccountsUseCase.execute()
        let accountsData = mapper.map(accounts: accounts)
        await MainActor.run {
            store.dispatch(.budgetAccountsDataLoaded(accountsData))
        }
    }
}
