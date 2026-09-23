//
//  AssignMoneyEffect.swift
//  Budgetary
//
//  Created by Phillip Baker on 13/01/2026.
//

import Factory
import Foundation

@MainActor
struct AssignMoneyEffect: AppEffect {
    private let store: AppStore
    private let assignMoneyUseCase: AssignMoneyUseCase
    private let loadBudgetUseCase: LoadBudgetUseCase
    
    let assignedAmount: Decimal
    let categoryID: BudgetRowID
    let monthYear: MonthYear
    
    init(
        store: AppStore = Container.shared.appStore(),
        assignMoneyUseCase: AssignMoneyUseCase = Container.shared.assignMoneyUseCase(),
        loadBudgetUseCase: LoadBudgetUseCase = Container.shared.loadBudgetUseCase(),
        assignedAmount: Decimal,
        categoryID: BudgetRowID,
        monthYear: MonthYear
    ) {
        self.store = store
        self.assignMoneyUseCase = assignMoneyUseCase
        self.loadBudgetUseCase = loadBudgetUseCase
        self.assignedAmount = assignedAmount
        self.categoryID = categoryID
        self.monthYear = monthYear
    }
    
    func run() async {
        do {
            try await assignMoneyUseCase.execute(assignedAmount, for: categoryID, in: monthYear)
            store.dispatch(.assignMoneySucceeded)
        } catch {
            store.dispatch(.assignMoneyFailed)
        }
    }
}
