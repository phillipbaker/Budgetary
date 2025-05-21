//
//  AccountsMapper.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/05/2025.
//

public final class BudgetAccountsMapper: Sendable {
    func mapAccounts(from data: CombinedAccountsData) -> [BudgetAccount] {
        data.accounts.map { account in
            map(account: account, fromPayees: data.payees, andCategoryGroups: data.categoryGroups)
        }
    }
    
    func map(account: BudgetAccountPlain, fromPayees payees: [PayeePlain], andCategoryGroups categoryGroups: [CategoryGroupPlain]) -> BudgetAccount {
        return BudgetAccount(
            id: account.id,
            nickname: account.nickname,
            accountType: account.accountType,
            startingBalance: account.startingBalance,
            notes: account.notes,
            isClosed: account.isClosed,
            transactions: map(transactions: account.transactions, fromPayees: payees, andCategoryGroups: categoryGroups)
        )
    }
    
    func map(transactions: [TransactionPlain], fromPayees payees: [PayeePlain], andCategoryGroups categoryGroups: [CategoryGroupPlain]) -> [TransactionEntity] {
        return transactions.map { transaction in
            map(transaction: transaction, fromPayees: payees, andCategoryGroups: categoryGroups)
        }
    }
    
    func map(transaction: TransactionPlain, fromPayees payees: [PayeePlain], andCategoryGroups categoryGroups: [CategoryGroupPlain]) -> TransactionEntity {
        return TransactionEntity(
            date: transaction.date,
            payee: TransactionMapper.map(payeeId: transaction.payeeId, payeesPlain: payees, categoryGroups: categoryGroups),
            category: TransactionMapper.mapCategory(categoryId: transaction.categoryId, categoryGroups: categoryGroups),
            amount: transaction.amount,
            isCleared: transaction.isCleared
        )
    }
    
    // MARK: - Entity to Plain
    
    func map(account: BudgetAccount) -> BudgetAccountPlain {
        return BudgetAccountPlain(
            id: account.id,
            nickname: account.nickname,
            accountType: account.accountType,
            startingBalance: account.startingBalance,
            notes: account.notes,
            isClosed: account.isClosed,
            transactions: map(transactions: account.transactions)
        )
    }
    
    func map(transactions: [TransactionEntity]) -> [TransactionPlain] {
        transactions.map { transaction in
            map(transaction: transaction)
        }
    }
    
    func map(transaction: TransactionEntity) -> TransactionPlain {
        return TransactionPlain(
            id: transaction.id,
            date: transaction.date,
            payeeId: transaction.payee?.id,
            categoryId: transaction.category?.id,
            memo: transaction.memo,
            amount: transaction.amount,
            isCleared: transaction.isCleared
        )
    }
}
