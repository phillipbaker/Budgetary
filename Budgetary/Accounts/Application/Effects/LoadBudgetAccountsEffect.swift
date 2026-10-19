//
//  LoadBudgetAccountsEffect.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/05/2025.
//

import Factory

@MainActor
struct LoadBudgetAccountsEffect: AppEffect {
    private let store: AppStore
    private let mapper: BudgetAccountsMapper
    private let loadBudgetAccountsUseCase: LoadBudgetAccountsUseCase
    
    init(
        store: AppStore = Container.shared.appStore(),
        mapper: BudgetAccountsMapper = Container.shared.budgetAccountsMapper(),
        loadBudgetAccountsUseCase: LoadBudgetAccountsUseCase = Container.shared.loadBudgetAccountsUseCase()
    ) {
        self.store = store
        self.mapper = mapper
        self.loadBudgetAccountsUseCase = loadBudgetAccountsUseCase
    }
    
    func run() async {
        let accounts = await loadBudgetAccountsUseCase.execute()
        let accountsData = mapper.map(accounts: accounts)
        await MainActor.run {
            store.dispatch(.loadBudgetAccountsSucceeded(accountsData))
        }
    }
}
