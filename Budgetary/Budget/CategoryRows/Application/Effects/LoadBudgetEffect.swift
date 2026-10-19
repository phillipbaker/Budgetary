//
//  LoadBudgetEffect.swift
//  Budgetary
//
//  Created by Phillip Baker on 17/01/2026.
//

import Factory

struct LoadBudgetEffect: AppEffect {
    private let store: AppStore
    private let loadBudgetUseCase: LoadBudgetUseCase
    
    init(
        store: AppStore = Container.shared.appStore(),
        loadBudgetUseCase: LoadBudgetUseCase = Container.shared.loadBudgetUseCase()
    ) {
        self.store = store
        self.loadBudgetUseCase = loadBudgetUseCase
    }
    
    func run() async {
        do {
            let budgetData = try await loadBudgetUseCase.execute()
            store.dispatch(.loadBudgetSucceeded(budgetData))
        } catch {
            store.dispatch(.loadBudgetFailed)
        }
    }
}
