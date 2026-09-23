//
//  AppEffect.swift
//  Budgetary
//
//  Created by Phillip Baker on 19/01/2026.
//

@MainActor
protocol AppEffect {
    func run() async
}

@MainActor
struct EffectRunner {
    func run(_ effects: [AppEffect]) {
        for effect in effects {
            Task { @MainActor in
                await effect.run()
            }
        }
    }
}
