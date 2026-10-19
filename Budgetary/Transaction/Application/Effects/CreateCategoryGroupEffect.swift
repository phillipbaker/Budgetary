//
//  CreateCategoryGroupEffect.swift
//  Budgetary
//
//  Created by Phillip Baker on 23/04/2026.
//

import Factory

struct CreateCategoryGroupEffect: AppEffect {
    private let store: AppStore
    private let createCategoryGroupUseCase: CreateCategoryGroupUseCase
    
    let name: String
    
    init(
        store: AppStore = Container.shared.appStore(),
        createCategoryGroupUseCase: CreateCategoryGroupUseCase = Container.shared.createCategoryGroupUseCase(),
        name: String
    ) {
        self.store = store
        self.createCategoryGroupUseCase = createCategoryGroupUseCase
        self.name = name
    }
    
    func run() async {
        await createCategoryGroupUseCase.execute(for: name)
        await MainActor.run {
            store.dispatch(.createCategoryGroupSucceeded)
        }
    }
}
