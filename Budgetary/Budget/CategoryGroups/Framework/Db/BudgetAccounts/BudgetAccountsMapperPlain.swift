//
//  BudgetAccountsMapperPlain.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

public class BudgetAccountsMapperPlain {
    func mapDbToPlain(budgetAccountsDb: [BudgetAccountDb]) -> [BudgetAccountPlain] {
        return budgetAccountsDb.map { budgetAccountDb in
            mapDbToPlain(budgetAccountDb: budgetAccountDb)
        }
    }
    
    func mapDbToPlain(budgetAccountDb: BudgetAccountDb) -> BudgetAccountPlain {
        return BudgetAccountPlain(
            id: budgetAccountDb.id,
            nickname: budgetAccountDb.nickname,
            accountType: budgetAccountDb.accountType,
            startingBalance: budgetAccountDb.startingBalance,
            notes: budgetAccountDb.notes,
            isClosed: budgetAccountDb.isClosed,
            transactions: mapToPlain(transactionsDb: budgetAccountDb.transactions)
        )
    }
    
    func mapPlainToDb(budgetAccountPlain: BudgetAccountPlain) -> BudgetAccountDb {
        return BudgetAccountDb(
            id: budgetAccountPlain.id,
            nickname: budgetAccountPlain.nickname,
            accountType: budgetAccountPlain.accountType,
            startingBalance: budgetAccountPlain.startingBalance,
            notes: budgetAccountPlain.notes,
            isClosed: budgetAccountPlain.isClosed,
            transactions: mapPlainToDb(transactionsPlain: budgetAccountPlain.transactions)
        )
    }
    
    func mapToPlain(transactionsDb: [TransactionDb]) -> [TransactionPlain] {
        return transactionsDb.map { transactionDb in
            mapDbToPlain(transactionDb: transactionDb)
        }
    }
    
    func mapDbToPlain(transactionDb: TransactionDb) -> TransactionPlain {
        return TransactionPlain(
            id: transactionDb.id,
            date: transactionDb.date,
            payeeId: transactionDb.payeeId,
            categoryId: transactionDb.categoryId,
            memo: transactionDb.memo,
            amount: transactionDb.amount,
            isCleared: transactionDb.isCleared
        )
    }
    
    func mapPlainToDb(transactionsPlain: [TransactionPlain]) -> [TransactionDb] {
        return transactionsPlain.map { transactionPlain in
            mapPlainToDb(transactionPlain: transactionPlain)
        }
    }

    func mapPlainToDb(transactionPlain: TransactionPlain) -> TransactionDb {
        return TransactionDb(
            id: transactionPlain.id,
            date: transactionPlain.date,
            payeeId: transactionPlain.payeeId,
            categoryId: transactionPlain.categoryId,
            memo: transactionPlain.memo,
            amount: transactionPlain.amount,
            isCleared: transactionPlain.isCleared
        )
    }
}
