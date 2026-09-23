//
//  SavePlain.swift
//  Budgetary
//
//  Created by Phillip Baker on 22/09/2026.
//

/// A pure description of what a save must do. Produced by `reconcile`,
/// executed by the save use case. No I/O, fully `Equatable` → unit-testable.
struct SavePlan: Equatable {

    enum PrimarySaveAction: Equatable {
        case upsert(into: ID<BudgetAccount>)
        case move(from: ID<BudgetAccount>, to: ID<BudgetAccount>)
    }

    enum CounterpartSaveAction: Equatable {
        case none
        case create(id: ID<BudgetTransaction>, in: ID<BudgetAccount>)
        case update(id: ID<BudgetTransaction>, in: ID<BudgetAccount>)
        case delete(id: ID<BudgetTransaction>, from: ID<BudgetAccount>)
        case replace(deleteID: ID<BudgetTransaction>, from: ID<BudgetAccount>,
                     createID: ID<BudgetTransaction>, in: ID<BudgetAccount>)
    }

    /// The linkedTransactionID the primary leg should carry after the save.
    let primaryLinkID: ID<BudgetTransaction>?
    let primarySaveAction: PrimarySaveAction
    let counterpartSaveAction: CounterpartSaveAction
}
