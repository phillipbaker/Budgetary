//
//  BudgetAccountsMapperPlain.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

import Foundation

public class BudgetAccountsMapperPlain {
    func mapDbToPlain(budgetAccountsDb: [BudgetAccountDb]) -> [BudgetAccountPlain] {
        return budgetAccountsDb.map { budgetAccountDb in
            mapDbToPlain(budgetAccountDb: budgetAccountDb)
        }
    }
    
    func mapDbToPlain(budgetAccountDb: BudgetAccountDb) -> BudgetAccountPlain {
        return BudgetAccountPlain(
            id: ID<BudgetAccountPlain>(budgetAccountDb.externalID),
            name: budgetAccountDb.name,
            accountType: map(accountType: budgetAccountDb.accountType),
            startingBalance: budgetAccountDb.startingBalance,
            notes: budgetAccountDb.notes,
            isClosed: budgetAccountDb.isClosed,
            transactions: mapToPlain(transactionsDb: budgetAccountDb.transactions)
        )
    }
    
    func mapPlainToDb(budgetAccountPlain: BudgetAccountPlain) -> BudgetAccountDb {
        return BudgetAccountDb(
            externalID: budgetAccountPlain.id.rawValue,
            name: budgetAccountPlain.name,
            accountType: map(accountType: budgetAccountPlain.accountType),
            startingBalance: budgetAccountPlain.startingBalance,
            notes: budgetAccountPlain.notes,
            isClosed: budgetAccountPlain.isClosed,
            transactions: mapPlainToDb(transactionsPlain: budgetAccountPlain.transactions)
        )
    }
    
    func map(accountType: BudgetAccountTypePlain) -> BudgetAccountTypeDb {
        switch accountType {
        case .cash:
            return .cash
        case .checking:
            return .checking
        case .savings:
            return .savings
        case .creditCard:
            return .creditCard
        }
    }
    
    func map(accountType: BudgetAccountTypeDb) -> BudgetAccountTypePlain {
        switch accountType {
        case .cash:
            return .cash
        case .checking:
            return .checking
        case .savings:
            return .savings
        case .creditCard:
            return .creditCard
        }
    }
    
    func mapToPlain(transactionsDb: [TransactionDb]) -> [TransactionPlain] {
        return transactionsDb.map { transactionDb in
            mapDbToPlain(transactionDb: transactionDb)
        }
    }
    
    func mapDbToPlain(transactionDb: TransactionDb) -> TransactionPlain {
        return TransactionPlain(
            id: ID<TransactionPlain>(transactionDb.externalID),
            date: transactionDb.date,
            memo: transactionDb.memo,
            amount: transactionDb.amount,
            isCleared: transactionDb.isCleared,
            payeeID: transactionDb.payeeID.map(ID<PayeePlain>.init),
            categoryID: transactionDb.categoryID.map(ID<CategoryPlain>.init)
        )
    }
    
    func mapPlainToDb(transactionsPlain: [TransactionPlain]) -> [TransactionDb] {
        return transactionsPlain.map { transactionPlain in
            mapPlainToDb(transactionPlain: transactionPlain)
        }
    }

    func mapPlainToDb(transactionPlain: TransactionPlain) -> TransactionDb {
        return TransactionDb(
            externalID: transactionPlain.id.rawValue,
            date: transactionPlain.date,
            memo: transactionPlain.memo,
            amount: transactionPlain.amount,
            isCleared: transactionPlain.isCleared,
            payeeID: ID<PayeeDb>(transactionPlain.payeeID),
            categoryID: ID<CategoryDb>(transactionPlain.categoryID)
        )
    }
}
