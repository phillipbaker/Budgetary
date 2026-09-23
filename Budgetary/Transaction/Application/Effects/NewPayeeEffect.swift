//
//  NewPayeeEffect.swift
//  Budgetary
//
//  Created by Phillip Baker on 01/02/2026.
//

import Factory

struct NewPayeeEffect: AppEffect {
    private let store: AppStore
    private let newPayeeUseCase: NewPayeeUseCase
    
    let name: String
    
    init(
        store: AppStore = Container.shared.appStore(),
        newPayeeUseCase: NewPayeeUseCase = Container.shared.newPayeeUseCase(),
        name: String
    ) {
        self.store = store
        self.newPayeeUseCase = newPayeeUseCase
        self.name = name
    }
    
    func run() async {
        await newPayeeUseCase.execute(for: name)
        await MainActor.run {
            store.dispatch(.createNewPayeeSucceeded)
        }
    }
}
