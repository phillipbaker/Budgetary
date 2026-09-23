//
//  NewGroupEffect.swift
//  Budgetary
//
//  Created by Phillip Baker on 23/04/2026.
//

import Factory

struct NewGroupEffect: AppEffect {
    private let store: AppStore
    private let newGroupUseCase: NewGroupUseCase
    
    let name: String
    
    init(
        store: AppStore = Container.shared.appStore(),
        newGroupUseCase: NewGroupUseCase = Container.shared.newGroupUseCase(),
        name: String
    ) {
        self.store = store
        self.newGroupUseCase = newGroupUseCase
        self.name = name
    }
    
    func run() async {
        await newGroupUseCase.execute(for: name)
        await MainActor.run {
            store.dispatch(.newCategoryGroupSucceeded)
        }
    }
}
