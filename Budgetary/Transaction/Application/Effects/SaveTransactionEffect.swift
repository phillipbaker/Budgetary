//
//  SaveTransactionEffect.swift
//  Budgetary
//
//  Created by Phillip Baker on 11/09/2026.
//

import Factory

struct SaveTransactionEffect: AppEffect {
    private let store: AppStore
    private let saveTransactionUseCase: SaveTransactionUseCase
    
    let request: SaveTransactionRequest
    
    init(
        store: AppStore = Container.shared.appStore(),
        addTransactionUseCase: SaveTransactionUseCase = Container.shared.saveTransactionUseCase(),
        request: SaveTransactionRequest
    ) {
        self.store = store
        self.saveTransactionUseCase = addTransactionUseCase
        self.request = request
    }
    
    func run() async {
        do {
            try await saveTransactionUseCase.execute(for: request)
            await MainActor.run {
                store.dispatch(.saveTransactionSucceeded)
            }
        } catch {
            await MainActor.run {
                store.dispatch(.saveTransactionFailed)
            }
        }
    }
}
