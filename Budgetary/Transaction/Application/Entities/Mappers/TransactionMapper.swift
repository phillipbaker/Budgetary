//
//  TransactionMapper.swift
//  Budgetary
//
//  Created by Phillip Baker on 22/05/2025.
//

import Foundation

enum TransactionMapper {
    static func map(transactionPlain: TransactionPlain, for account: BudgetAccountPlain, fromPayees payees: [PayeePlain], andCategoryGroups categoryGroups: [CategoryGroupPlain]) -> BudgetTransaction {
        return BudgetTransaction(
            id: ID<BudgetTransaction>(transactionPlain.id),
            date: transactionPlain.date,
            memo: transactionPlain.memo,
            amount: transactionPlain.amount,
            isCleared: transactionPlain.isCleared,
            payee: map(payeeID: transactionPlain.payeeID, payeesPlain: payees, categoryGroups: categoryGroups),
            category: mapCategory(categoryID: transactionPlain.categoryID, categoryGroups: categoryGroups),
            account: TransactionAccount(id: ID<TransactionAccount>(account.id), name: account.name),
            linkedTransactionID: nil
        )
    }

    static func map(account: BudgetAccountPlain, fromPayees payees: [PayeePlain], andCategoryGroups categoryGroups: [CategoryGroupPlain]) -> BudgetAccount {
        return BudgetAccount(
            id: ID<BudgetAccount>(account.id),
            name: account.name,
            type: map(accountTypePlain: account.accountType),
            startingBalance: account.startingBalance,
            notes: account.notes,
            isClosed: account.isClosed,
            transactions: mapTransactions(for: account, fromPayees: payees, andCategoryGroups: categoryGroups)
        )
    }
    
    static func map(accountTypePlain: BudgetAccountTypePlain) -> BudgetAccountType {
        switch accountTypePlain {
        case .cash:
            return .cash(.cash)
        case .checking:
            return .cash(.checking)
        case .savings:
            return .cash(.savings)
        case .creditCard:
            return .credit(.creditCard)
        }
    }

    static func mapTransactions(for account: BudgetAccountPlain, fromPayees payees: [PayeePlain], andCategoryGroups categoryGroups: [CategoryGroupPlain]) -> [BudgetTransaction] {
        return account.transactions.map { transactionPlain in
            map(transactionPlain: transactionPlain, for: account, fromPayees: payees, andCategoryGroups: categoryGroups)
        }
    }
    
    static func map(transaction: TransactionPlain, for account: BudgetAccountPlain, fromPayees payees: [PayeePlain], andCategoryGroups categoryGroups: [CategoryGroupPlain]) -> BudgetTransaction {
        return BudgetTransaction(
            id: ID<BudgetTransaction>(transaction.id),
            date: transaction.date,
            memo: transaction.memo,
            amount: transaction.amount,
            isCleared: transaction.isCleared,
            payee: Self.map(payeeID: transaction.payeeID, payeesPlain: payees, categoryGroups: categoryGroups),
            category: Self.mapCategory(categoryID: transaction.categoryID, categoryGroups: categoryGroups),
            account: TransactionAccount(id: ID<TransactionAccount>(account.id), name: account.name),
            linkedTransactionID: nil
        )
    }
    
    static func map(payeeID: ID<PayeePlain>?, payeesPlain: [PayeePlain], categoryGroups: [CategoryGroupPlain]) -> Payee? {
        guard let payeePlain = payeesPlain.first(where: { payeeID == $0.id }) else { return nil }
        return map(payeePlain: payeePlain, categoryGroups: categoryGroups)
    }
    
    static func map(payeePlain: PayeePlain, categoryGroups: [CategoryGroupPlain]) -> Payee {
        return Payee(
            id: ID<Payee>(payeePlain.id),
            name: payeePlain.name,
            type: map(payeeTypePlain: payeePlain.type),
            aliases: payeePlain.aliases,
            includedInPayeeList: payeePlain.includedInPayeeList,
            automaticallyCategorizeIsOn: payeePlain.automaticallyCategorizeIsOn,
            defaultCategory: mapCategory(categoryID: payeePlain.defaultCategoryID, categoryGroups: categoryGroups)
        )
    }
    
    static func mapCategory(categoryID: ID<CategoryPlain>?, categoryGroups: [CategoryGroupPlain]) -> TransactionCategory? {
        let categories = categoryGroups.flatMap { $0.categories } // [CategoryPlain]
        guard let matchingCategory = categories.first(where: { categoryID == $0.id }) else { return nil }
        return map(categoryPlain: matchingCategory)
    }
    
    static func map(categoryPlain: CategoryPlain) -> TransactionCategory {
        return TransactionCategory(id: ID<TransactionCategory>(categoryPlain.id), name: categoryPlain.name)
    }
    
    static func map(payeeTypePlain: PayeeTypePlain) -> PayeeType {
        switch payeeTypePlain {
        case .regular: return .regular
        case .transfer(let accountID): return .transfer(ID<BudgetAccount>(accountID))
        }
    }
}
