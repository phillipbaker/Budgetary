//
//  AccountsMapper.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/05/2025.
//

import Foundation

public final class BudgetAccountsMapper: Sendable {
    func map(accounts: [BudgetAccount]) -> [AccountData] {
        accounts.map { account in
            map(account: account)
        }
    }
    
    func map(account: BudgetAccount) -> AccountData {
        AccountData(
            id: ID<AccountData>(account.id),
            name: account.name,
            type: account.type,
            notes: account.notes,
            isClosed: account.isClosed,
            balance: account.balance,
            startingBalance: account.startingBalance,
            transactions: map(transactions: account.transactions)
        )
    }
    
    func map(transactions: [BudgetTransaction]) -> [TransactionData] {
        transactions.map { transaction in
            map(transaction: transaction)
        }
    }
    
    func map(transaction: BudgetTransaction) -> TransactionData {
        return TransactionData(
            id: ID<TransactionData>(transaction.id),
            date: transaction.date,
            memo: transaction.memo,
            amount: transaction.amount,
            isCleared: transaction.isCleared,
            payee: transaction.payee,
            category: transaction.category,
            account: transaction.account // TODO: This needs ot be a var TransactionAccountData so it’s mutable...
        )
    }

    func map(accounts: [BudgetAccountPlain], payees: [PayeePlain], categoryGroups: [CategoryGroupPlain]) -> [BudgetAccount] {
        accounts.map { account in
            map(account: account, payees: payees, categoryGroups: categoryGroups)
        }
    }
    
    func map(account: BudgetAccountPlain, payees: [PayeePlain], categoryGroups: [CategoryGroupPlain]) -> BudgetAccount {
        return BudgetAccount(
            id: ID<BudgetAccount>(account.id),
            name: account.name,
            type: TransactionMapper.map(accountTypePlain: account.accountType),
            startingBalance: account.startingBalance,
            notes: account.notes,
            isClosed: account.isClosed,
            transactions: TransactionMapper.mapTransactions(for: account, fromPayees: payees, andCategoryGroups: categoryGroups)
        )
    }
    
    func map(accounts: [BudgetAccountPlain]) -> [TransactionAccount] {
        accounts.map { account in
            map(account: account)
        }
    }
    
    func map(account: BudgetAccountPlain) -> TransactionAccount {
        return TransactionAccount(id: ID<TransactionAccount>(account.id), name: account.name)
    }
    
    func map(account: BudgetAccountPlain, fromPayees payees: [PayeePlain], andCategoryGroups categoryGroups: [CategoryGroupPlain]) -> BudgetAccount {
        TransactionMapper.map(account: account, fromPayees: payees, andCategoryGroups: categoryGroups)
    }
    
    func map(payeePlain: PayeePlain, categoryGroups: [CategoryGroupPlain]) -> Payee {
        TransactionMapper.map(payeePlain: payeePlain, categoryGroups: categoryGroups)
    }
    
    func map(categoryPlain: CategoryPlain) -> TransactionCategory {
        TransactionMapper.map(categoryPlain: categoryPlain)
    }
    
    // MARK: - Entity to Plain
    
    // TODO: This seems like an infinite loop
    
    func map(account: BudgetAccount) -> BudgetAccountPlain {
        return BudgetAccountPlain(
            id: ID<BudgetAccountPlain>(account.id),
            name: account.name,
            accountType: map(accountType: account.type),
            startingBalance: account.startingBalance,
            notes: account.notes,
            isClosed: account.isClosed,
            transactions: map(transactions: account.transactions)
        )
    }
    
    func map(accountType: BudgetAccountType) -> BudgetAccountTypePlain {
        switch accountType {
        case .cash(let cashAccountType):
            map(cashAccountType: cashAccountType)
        case .credit(let creditAccountType):
            map(creditAccountType: creditAccountType)
        }
    }
    
    func map(cashAccountType: CashAccountType) -> BudgetAccountTypePlain {
        switch cashAccountType {
        case .cash:
            return .cash
        case .checking:
            return .checking
        case .savings:
            return .savings
        }
    }
    
    func map(creditAccountType: CreditAccountType) -> BudgetAccountTypePlain {
        switch creditAccountType {
        case .creditCard:
            return .creditCard
        }
    }
    
    func map(transactions: [BudgetTransaction]) -> [TransactionPlain] {
        transactions.map { transaction in
            map(transaction: transaction)
        }
    }
    
    func map(transaction: BudgetTransaction) -> TransactionPlain {
        return TransactionPlain(
            id: ID<TransactionPlain>(transaction.id),
            date: transaction.date,
            memo: transaction.memo,
            amount: transaction.amount,
            isCleared: transaction.isCleared,
            payeeID: ID<PayeePlain>(transaction.payee?.id),
            categoryID: ID<CategoryPlain>(transaction.category?.id)
        )
    }
    
    func map(accountType: BudgetAccountTypePresentation) -> BudgetAccountType {
        switch accountType {
        case .cash(.cash):
            return .cash(.cash)
        case .cash(.checking):
            return .cash(.checking)
        case .cash(.savings):
            return .cash(.savings)
        case .credit(.creditCard):
            return .credit(.creditCard)
        }
    }
    
    func map(creditCardPaymentGroupPlain: CreditCardPaymentGroupPlain) -> CreditCardPaymentGroup {
        CreditCardPaymentMapper.map(creditCardPaymentGroupPlain: creditCardPaymentGroupPlain)
    }
    
    func map(creditCardPaymentGroup: CreditCardPaymentGroup) -> CreditCardPaymentGroupPlain {
        CreditCardPaymentMapper.map(creditCardPaymentGroup: creditCardPaymentGroup)
    }
    
    func map(payee: Payee) -> PayeePlain {
        return PayeePlain(
            id: ID<PayeePlain>(payee.id),
            name: payee.name,
            type: map(payeeType: payee.type),
            aliases: payee.aliases,
            includedInPayeeList: payee.includedInPayeeList,
            automaticallyCategorizeIsOn: payee.includedInPayeeList,
            defaultCategoryID: ID<CategoryPlain>(payee.defaultCategory?.id)
        )
    }
    
    func map(payeeType: PayeeType) -> PayeeTypePlain {
        switch payeeType {
        case .regular: .regular
        case .transfer(let accountID): .transfer(ID<BudgetAccountPlain>(accountID))
        }
    }
}
