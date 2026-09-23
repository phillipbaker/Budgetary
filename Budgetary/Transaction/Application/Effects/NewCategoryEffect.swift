//
//  NewCategoryEffect.swift
//  Budgetary
//
//  Created by Phillip Baker on 23/04/2026.
//

import Factory

struct NewCategoryEffect: AppEffect {
    private let store: AppStore
    private let newCategoryUseCase: NewCategoryUseCase
    
    let name: String
    let groupID: ID<CategoryGroup>
    
    init(
        store: AppStore = Container.shared.appStore(),
        newCategoryUseCase: NewCategoryUseCase = Container.shared.newCategoryUseCase(),
        name: String,
        groupID: ID<CategoryGroup>
    ) {
        self.store = store
        self.newCategoryUseCase = newCategoryUseCase
        self.name = name
        self.groupID = groupID
    }
    
    func run() async {
        await newCategoryUseCase.execute(for: name, andGroupID: groupID)
        await MainActor.run {
            store.dispatch(.createNewCategorySucceeded)
        }
    }
}
