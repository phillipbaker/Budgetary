//
//  CreatePayeeEffect.swift
//  Budgetary
//
//  Created by Phillip Baker on 01/02/2026.
//

import Factory

struct CreatePayeeEffect: AppEffect {
    private let store: AppStore
    private let createPayeeUseCase: CreatePayeeUseCase
    
    let name: String
    
    init(
        store: AppStore = Container.shared.appStore(),
        createPayeeUseCase: CreatePayeeUseCase = Container.shared.createPayeeUseCase(),
        name: String
    ) {
        self.store = store
        self.createPayeeUseCase = createPayeeUseCase
        self.name = name
    }
    
    func run() async {
        await createPayeeUseCase.execute(for: name)
        await MainActor.run {
            store.dispatch(.createPayeeSucceeded)
        }
    }
}
