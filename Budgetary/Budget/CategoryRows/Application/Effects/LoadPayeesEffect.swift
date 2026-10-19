//
//  LoadPayeesEffect.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/01/2026.
//

import Factory

struct LoadPayeesEffect: AppEffect {
    private let store: AppStore
    private let loadPayeesUseCase: LoadPayeesUseCase
    
    init(
        store: AppStore = Container.shared.appStore(),
        loadPayeesUseCase: LoadPayeesUseCase = Container.shared.loadPayeesUseCase()
    ) {
        self.store = store
        self.loadPayeesUseCase = loadPayeesUseCase
    }
    
    func run() async {
        let payees = await loadPayeesUseCase.execute()
        await MainActor.run {
            store.dispatch(.loadPayeesSucceeded(payees))
        }
    }
}
