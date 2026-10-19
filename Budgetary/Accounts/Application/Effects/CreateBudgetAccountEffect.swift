//
//  CreateBudgetAccountEffect.swift
//  Budgetary
//
//  Created by Phillip Baker on 20/01/2026.
//

import Factory
import Foundation

@MainActor
struct CreateBudgetAccountEffect: AppEffect {
    private let store: AppStore
    private let mapper: BudgetAccountsMapper
    private let createBudgetAccountUseCase: CreateBudgetAccountUseCase
    
    let name: String
    let accountType: BudgetAccountType
    let startingBalance: Decimal
    
    init(
        store: AppStore = Container.shared.appStore(),
        mapper: BudgetAccountsMapper = Container.shared.budgetAccountsMapper(),
        createBudgetAccountUseCase: CreateBudgetAccountUseCase = Container.shared.createBudgetAccountUseCase(),
        name: String,
        accountType: BudgetAccountType,
        startingBalance: Decimal
    ) {
        self.store = store
        self.mapper = mapper
        self.createBudgetAccountUseCase = createBudgetAccountUseCase
        self.name = name
        self.accountType = accountType
        self.startingBalance = startingBalance
    }
    
    func run() async {
        // TODO: errors/handling in here? Can it still fail or have I done that checking already?
        await createBudgetAccountUseCase.execute(
            name: name,
            accountType: accountType,
            startingBalance: startingBalance
        )
        store.dispatch(.createBudgetAccountSucceeded)
    }
}

