//
//  LoadBudgetEffect.swift
//  Budgetary
//
//  Created by Phillip Baker on 17/01/2026.
//

import Factory

struct LoadBudgetEffect: AppEffect {
    private let store: AppStore
    private let loadBudgetDataUseCase: LoadBudgetUseCase
    
    init(
        store: AppStore = Container.shared.appStore(),
        loadBudgetDataUseCase: LoadBudgetUseCase = Container.shared.loadBudgetUseCase()
    ) {
        self.store = store
        self.loadBudgetDataUseCase = loadBudgetDataUseCase
    }
    
    func run() async {
        let budgetData = await loadBudgetDataUseCase.execute()
        await MainActor.run {
            store.dispatch(.loadBudgetSucceeded(budgetData))
        }
    }
}
