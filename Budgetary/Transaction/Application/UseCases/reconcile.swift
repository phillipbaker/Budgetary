//
//  reconcile.swift
//  Budgetary
//
//  Created by Phillip Baker on 22/09/2026.
//

extension BudgetTransaction {
    /// The account this transfers to, if its payee is a transfer.
    var transferDestination: ID<BudgetAccount>? {
        if case let .transfer(destination) = payee?.type { return destination }
        return nil
    }
}

/// Decides what a save should do. Pure: same inputs → same plan.
/// - `newDestinationAccountID`: the resolved transfer target of the request's payee
///   (nil when the payee is regular). The caller resolves it — that's the only
///   I/O; keeping it a parameter keeps this function pure.
/// - `makeID`: injected so tests are deterministic.
func reconcile(
    existingTransaction: BudgetTransaction?,
    saveRequest: SaveTransactionRequest,
    destinationAccountID: ID<BudgetAccount>?,
    makeID: () -> ID<BudgetTransaction> = { ID<BudgetTransaction>() }
) -> SavePlan {

    // Primary Save Action
    let primarySaveAction: SavePlan.PrimarySaveAction
    
    if let oldAccountID = existingTransaction.map({ ID<BudgetAccount>($0.account.id) }),
       oldAccountID != saveRequest.accountID {
        // account changed → move
        primarySaveAction = .move(from: oldAccountID, to: saveRequest.accountID)
    } else {
        primarySaveAction = .upsert(into: saveRequest.accountID)
    }

    // Counterpart Save Action
    let counterpartSaveAction: SavePlan.CounterpartSaveAction
    
    let primaryLinkID: ID<BudgetTransaction>?
    let oldDestination = existingTransaction?.transferDestination
    let oldCounterpartID = existingTransaction?.linkedTransactionID

    switch (oldCounterpartID, destinationAccountID) {

    // regular → regular
    case (nil, nil):
        counterpartSaveAction = .none
        primaryLinkID = nil

    // regular → transfer
    case (nil, .some(let destination)):
        let id = makeID()
        counterpartSaveAction = .create(id: id, in: destination)
        primaryLinkID = id

    // transfer → regular
    case (.some(let oldID), nil):
        if let oldDestination {
            counterpartSaveAction = .delete(id: oldID, from: oldDestination)
        } else {
            assertionFailure("Linked transaction \(oldID) has no transfer destination")
            counterpartSaveAction = .none
        }
        primaryLinkID = nil

    // transfer → transfer
    case (.some(let oldID), .some(let newDest)):
        // same destination → update in place
        if oldDestination == newDest {
            counterpartSaveAction = .update(id: oldID, in: newDest)
            primaryLinkID = oldID
        } else {
            // destination changed → replace
            let newID = makeID()
            counterpartSaveAction = .replace(deleteID: oldID, from: oldDestination ?? newDest,
                                     createID: newID, in: newDest)
            primaryLinkID = newID
        }
    }

    return SavePlan(primaryLinkID: primaryLinkID, primarySaveAction: primarySaveAction, counterpartSaveAction: counterpartSaveAction)
}
