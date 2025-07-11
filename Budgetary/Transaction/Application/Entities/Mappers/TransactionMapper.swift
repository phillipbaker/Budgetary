//
//  TransactionMapper.swift
//  Budgetary
//
//  Created by Phillip Baker on 22/05/2025.
//

enum TransactionMapper {
    static func mapTransactions(for account: BudgetAccountPlain, fromPayees payees: [PayeePlain], andCategoryGroups categoryGroups: [CategoryGroupPlain]) -> [TransactionEntity] {
        return account.transactions.map { transactionPlain in
            map(transactionPlain: transactionPlain, for: account, fromPayees: payees, andCategoryGroups: categoryGroups)
        }
    }
    
    static func map(transactionPlain: TransactionPlain, for account: BudgetAccountPlain, fromPayees payees: [PayeePlain], andCategoryGroups categoryGroups: [CategoryGroupPlain]) -> TransactionEntity {
        return TransactionEntity(
            id: transactionPlain.id,
            date: transactionPlain.date,
            memo: transactionPlain.memo,
            amount: transactionPlain.amount,
            isCleared: transactionPlain.isCleared,
            payee: map(payeeId: transactionPlain.payeeId, payeesPlain: payees, categoryGroups: categoryGroups),
            category: mapCategory(categoryId: transactionPlain.categoryId, categoryGroups: categoryGroups),
            account: TransactionAccount(id: account.id, name: account.name)
        )
    }

    static func map(account: BudgetAccountPlain, fromPayees payees: [PayeePlain], andCategoryGroups categoryGroups: [CategoryGroupPlain]) -> BudgetAccount {
        return BudgetAccount(
            id: account.id,
            name: account.name,
            accountType: account.accountType,
            startingBalance: account.startingBalance,
            notes: account.notes,
            isClosed: account.isClosed,
            transactions: map(transactions: account.transactions, forAccount: account, fromPayees: payees, andCategoryGroups: categoryGroups)
        )
    }
    
    static func map(transactions: [TransactionPlain], forAccount account: BudgetAccountPlain, fromPayees payees: [PayeePlain], andCategoryGroups categoryGroups: [CategoryGroupPlain]) -> [TransactionEntity] {
        return transactions.map { transaction in
            map(transaction: transaction, for: account, fromPayees: payees, andCategoryGroups: categoryGroups)
        }
    }
    
    static func map(transaction: TransactionPlain, for account: BudgetAccountPlain, fromPayees payees: [PayeePlain], andCategoryGroups categoryGroups: [CategoryGroupPlain]) -> TransactionEntity {
        return TransactionEntity(
            id: transaction.id,
            date: transaction.date,
            memo: transaction.memo,
            amount: transaction.amount,
            isCleared: transaction.isCleared,
            payee: Self.map(payeeId: transaction.payeeId, payeesPlain: payees, categoryGroups: categoryGroups),
            category: Self.mapCategory(categoryId: transaction.categoryId, categoryGroups: categoryGroups),
            account: TransactionAccount(id: account.id, name: account.name)
        )
    }
    
    static func map(payeeId: String?, payeesPlain: [PayeePlain], categoryGroups: [CategoryGroupPlain]) -> Payee? {
        guard let payeePlain = payeesPlain.first(where: { payeeId == $0.id }) else { return nil }
        return map(payeePlain: payeePlain, categoryGroups: categoryGroups)
    }
    
    static func map(payeePlain: PayeePlain, categoryGroups: [CategoryGroupPlain]) -> Payee {
        return Payee(
            id: payeePlain.id,
            name: payeePlain.name,
            aliases: payeePlain.aliases,
            includedInPayeeList: payeePlain.includedInPayeeList,
            automaticallyCategorizeIsOn: payeePlain.automaticallyCategorizeIsOn,
            defaultCategory: mapCategory(categoryId: payeePlain.defaultCategoryId, categoryGroups: categoryGroups)
        )
    }
    
    static func mapCategory(categoryId: String?, categoryGroups: [CategoryGroupPlain]) -> TransactionCategory? {
        let categories = categoryGroups.flatMap { $0.categories } // [CategoryPlain]
        guard let matchingCategory = categories.first(where: { categoryId == $0.id }) else { return nil }
        return map(categoryPlain: matchingCategory)
    }
    
    static func map(categoryPlain: CategoryPlain) -> TransactionCategory {
        return TransactionCategory(id: categoryPlain.id, name: categoryPlain.name)
    }
}
