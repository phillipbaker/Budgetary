//
//  CreateCategoryEffect.swift
//  Budgetary
//
//  Created by Phillip Baker on 23/04/2026.
//

import Factory

struct CreateCategoryEffect: AppEffect {
    private let store: AppStore
    private let createCategoryUseCase: CreateCategoryUseCase
    
    let name: String
    let groupID: ID<CategoryGroup>
    
    init(
        store: AppStore = Container.shared.appStore(),
        createCategoryUseCase: CreateCategoryUseCase = Container.shared.createCategoryUseCase(),
        name: String,
        groupID: ID<CategoryGroup>
    ) {
        self.store = store
        self.createCategoryUseCase = createCategoryUseCase
        self.name = name
        self.groupID = groupID
    }
    
    func run() async {
        await createCategoryUseCase.execute(for: name, andGroupID: groupID)
        await MainActor.run {
            store.dispatch(.createCategorySucceeded)
        }
    }
}
