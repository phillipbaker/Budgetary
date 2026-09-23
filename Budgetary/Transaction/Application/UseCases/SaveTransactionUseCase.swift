//
//  SaveTransactionUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 21/05/2025.
//

import Factory
import Foundation

final class SaveTransactionUseCase: Sendable {
    let source: SaveTransactionSource = Container.shared.saveTransactionSource()
    let mapper: BudgetAccountsMapper = Container.shared.budgetAccountsMapper()
    
    func saveTransaction(request: SaveTransactionRequest) async throws {
        let payees = await source.allPayees()
        let categoryGroups = await source.allCategoryGroups()
        
        let existingTransaction = await source
            .findAccount(containing: ID<TransactionPlain>(request.id))
            .map { mapper.map(account: $0, payees: payees, categoryGroups: categoryGroups) }
            .flatMap { $0.transactions.first { $0.id == request.id } }
        
        let destinationAccountID = transferDestination(ofPayeeID: request.payeeID, in: payees)
        
        // Throw if transaction account and payee account are the same
        if let dest = destinationAccountID, dest == request.accountID {
            throw SaveTransactionError.selfTransferError
        }
        
        let plan = reconcile(
            existingTransaction: existingTransaction, // nil → new
            saveRequest: request,
            destinationAccountID: destinationAccountID
        )
        
        switch plan.primarySaveAction {
        case .upsert(let accountID):
            let account = try await loadAccount(from: accountID, payees: payees, categoryGroups: categoryGroups)
            let transaction = try makePrimaryTransaction(from: request, primaryLinkID: plan.primaryLinkID, in: account, payees: payees, categoryGroups: categoryGroups)
            await source.update(account: mapper.map(account: account.upserting(transaction: transaction)))
        case .move(let fromAccountID, let toAccountID):
            let fromAccount = try await loadAccount(from: fromAccountID, payees: payees, categoryGroups: categoryGroups)
            let toAccount = try await loadAccount(from: toAccountID, payees: payees, categoryGroups: categoryGroups)
            let transaction = try makePrimaryTransaction(from: request, primaryLinkID: plan.primaryLinkID, in: toAccount, payees: payees, categoryGroups: categoryGroups)
            await source.update(account: mapper.map(account: fromAccount.deleting(transactionID: transaction.id)))
            await source.update(account: mapper.map(account: toAccount.upserting(transaction: transaction)))
        }
        
        // Execute Counterpart Action
        switch plan.counterpartSaveAction {
        case .none: break
        case .create(let transactionID, let accountID), .update(let transactionID, let accountID):
            let account = try await loadAccount(from: accountID, payees: payees, categoryGroups: categoryGroups)
            let counterpart = try makeCounterpartTransaction(id: transactionID, in: account, from: request, with: payees, and: categoryGroups)
            await source.update(account: mapper.map(account: account.upserting(transaction: counterpart)))
        case .delete(let transactionID, let accountID):
            let account = try await loadAccount(from: accountID, payees: payees, categoryGroups: categoryGroups)
            await source.update(account: mapper.map(account: account.deleting(transactionID: transactionID)))
        case .replace(let deleteID, let fromAccountID, let createID, let toAccountID):
            let fromAccount = try await loadAccount(from: fromAccountID, payees: payees, categoryGroups: categoryGroups)
            await source.update(account: mapper.map(account: fromAccount.deleting(transactionID: deleteID)))
            let toAccount = try await loadAccount(from: toAccountID, payees: payees, categoryGroups: categoryGroups)
            let counterpart = try makeCounterpartTransaction(id: createID, in: toAccount, from: request, with: payees, and: categoryGroups)
            await source.update(account: mapper.map(account: toAccount.upserting(transaction: counterpart)))
        }
    }
    
    private func transferDestination(ofPayeeID payeeID: ID<Payee>?, in payees: [PayeePlain]) -> ID<BudgetAccount>? {
        guard let payeeID, let payee = payees.first(where: { $0.id == ID<PayeePlain>(payeeID) }),
              case let .transfer(destination) = payee.type
        else {
            return nil
        }
        return ID<BudgetAccount>(destination)
    }
    
    private func loadAccount(from id: ID<BudgetAccount>, payees: [PayeePlain], categoryGroups: [CategoryGroupPlain]) async throws -> BudgetAccount {
        guard let accountPlain = await source.findBudgetAccount(by: ID<BudgetAccountPlain>(id)) else {
            throw SaveTransactionError.accountError
        }
        
        return mapper.map(account: accountPlain, payees: payees, categoryGroups: categoryGroups)
    }
    
    private func makePrimaryTransaction(
        from request: SaveTransactionRequest,
        primaryLinkID: ID<BudgetTransaction>?,
        in account: BudgetAccount,
        payees: [PayeePlain],
        categoryGroups: [CategoryGroupPlain]
    ) throws -> BudgetTransaction {
        var payee: Payee?
        
        if let payeeID = request.payeeID {
            guard let payeePlain = payees.first(where: { $0.id == ID<PayeePlain>(payeeID) }) else {
                throw SaveTransactionError.payeeError
            }
            payee = mapper.map(payeePlain: payeePlain, categoryGroups: categoryGroups)
        }
        
        var category: TransactionCategory?
        
        if let categoryID = request.categoryID {
            guard let categoryPlain = categoryGroups.flatMap(\.categories)
                .first(where: { $0.id == ID<CategoryPlain>(categoryID) }) else {
                throw SaveTransactionError.categoryError
            }
            category = mapper.map(categoryPlain: categoryPlain)
        }

        return BudgetTransaction(
            id: request.id,
            date: request.date,
            memo: request.memo,
            amount: request.amount,
            isCleared: request.isCleared,
            payee: payee,
            category: category,
            account: TransactionAccount(id: ID<TransactionAccount>(account.id), name: account.name),
            linkedTransactionID: primaryLinkID
        )
    }
    
    private func makeCounterpartTransaction(
        id: ID<BudgetTransaction>,
        in account: BudgetAccount,
        from request: SaveTransactionRequest,
        with payees: [PayeePlain],
        and categoryGroups: [CategoryGroupPlain]
    ) throws -> BudgetTransaction {
        
        let isCleared = account.transactions.first { $0.id == id }?.isCleared ?? false
        
        guard let transferSourcePayeePlain = payees.first(where: {
            if case let .transfer(accountID) = $0.type {
                return ID<BudgetAccount>(accountID) == request.accountID
            }
            return false
        }) else {
            throw SaveTransactionError.payeeError
        }

        let transferSourcePayee = mapper.map(payeePlain: transferSourcePayeePlain, categoryGroups: categoryGroups)
        
        return BudgetTransaction(
            id: id,
            date: request.date,
            memo: request.memo,
            amount: request.amount.inverted,
            isCleared: isCleared,
            payee: transferSourcePayee,
            category: nil,
            account: TransactionAccount(id: ID<TransactionAccount>(account.id), name: account.name),
            linkedTransactionID: request.id
        )
    }
}

extension Amount {
    var inverted: Amount {
        switch self {
        case .inflow(let value):  return .outflow(value)
        case .outflow(let value): return .inflow(value)
        }
    }
}
