//
//  AppStore.swift
//  Budgetary
//
//  Created by Phillip Baker on 12/01/2026.
//

@MainActor
final class AppStore {
    private var state: AppState
    private let reducer: (inout AppState, AppAction) -> [AppEffect]
    private let effectRunner: EffectRunner
    private var continuations: [UUID: AsyncStream<AppState>.Continuation] = [:]
    
    init(
        state: AppState = AppState(
            homeState: .init(
                selectedTab: .budget,
                sheet: nil
            ),
            payeesState: .notLoaded,
            budgetState: .notLoaded,
            accountsState: .notLoaded,
            transactionState: .notLoaded,
            monthYear: .currentMonthYear,
            filter: .allCategories,
            sheet: nil,
            currencyCode: "GBP"
        ),
        reducer: @escaping (inout AppState, AppAction) -> [AppEffect],
        effectRunner: EffectRunner
    ) {
        self.state = state
        self.reducer = reducer
        self.effectRunner = effectRunner
        broadcast(state)
    }
    
    func dispatch(_ action: AppAction) {
        let effects = reducer(&state, action)
        broadcast(state)
        
        for effect in effects {
            Task {
                if let next = await effectRunner.run(effect) {
                    dispatch(next)
                }
            }
        }
    }
    
    func currentState() -> AppState {
        state
    }

    func observe() -> AsyncStream<AppState> {
        AsyncStream { continuation in
            let token = UUID()
            // Register and yield on the MainActor to avoid cross-actor mutations
            Task { @MainActor in
                self.continuations[token] = continuation
                // Immediately send current state to new subscriber
                continuation.yield(self.state)
            }
            
            continuation.onTermination = { _ in
                // Hop back to the MainActor for mutation
                Task { @MainActor in
                    self.continuations[token] = nil
                }
            }
        }
    }
    
    func broadcast(_ state: AppState) {
        for continuation in continuations.values {
            continuation.yield(state)
        }
    }
}

import SwiftUI
extension AppStore {
    func binding<Value>(
        get: @escaping (AppState) -> Value,
        send: @escaping (Value) -> AppAction
    ) -> Binding<Value> {
        Binding(
            get: { get(self.state) },
            set: { self.dispatch(send($0)) }
        )
    }
    
    func readOnlyBinding<Value>(
        _ get: @escaping (AppState) -> Value
    ) -> Binding<Value> {
        Binding(
            get: { get(self.state) },
            set: { _ in /* do nothing */ }
        )
    }
}
