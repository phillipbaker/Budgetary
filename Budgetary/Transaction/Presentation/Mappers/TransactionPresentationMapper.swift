//
//  TransactionPresentationMapper.swift
//  Budgetary
//
//  Created by Phillip Baker on 22/05/2025.
//

import Foundation

enum TransactionPresentationMapper {
    static func map(transaction: BudgetTransaction) -> TransactionPresentation {
        return TransactionPresentation(
            id: ID<TransactionPresentation>(transaction.id),
            date: transaction.date.startOfDay(),
            memo: transaction.memo,
            amount: map(amount: transaction.amount),
            isCleared: transaction.isCleared,
            payee: map(payee: transaction.payee),
            category: map(category: transaction.category),
            account: map(transactionAccount: transaction.account),
            linkedTransactionID: transaction.id.rawValue
        )
    }
    
    static func map(transaction: TransactionData) -> TransactionPresentation {
        return TransactionPresentation(
            id: ID<TransactionPresentation>(transaction.id),
            date: transaction.date.startOfDay(),
            memo: transaction.memo,
            amount: map(amount: transaction.amount),
            isCleared: transaction.isCleared,
            payee: map(payee: transaction.payee),
            category: map(category: transaction.category),
            account: map(transactionAccount: transaction.account),
            linkedTransactionID: transaction.id.rawValue
        )
    }
    
    static func map(transaction: TransactionData?) -> TransactionPresentation? {
        guard let transaction else { return nil }
        return TransactionPresentation(
            id: ID<TransactionPresentation>(transaction.id),
            date: transaction.date.startOfDay(),
            memo: transaction.memo,
            amount: map(amount: transaction.amount),
            isCleared: transaction.isCleared,
            payee: map(payee: transaction.payee),
            category: map(category: transaction.category),
            account: map(transactionAccount: transaction.account),
            linkedTransactionID: transaction.id.rawValue
        )
    }
    
    static func map(transactionData: TransactionData?) -> TransactionDraft {
        guard let transaction = transactionData else { return TransactionDraft() }
        return TransactionDraft(
            id: ID<TransactionDraft>(transaction.id),
            date: transaction.date,
            memo: transaction.memo,
            amount: map(amount: transaction.amount),
            isCleared: transaction.isCleared,
            payee: map(payee: transaction.payee),
            account: map(transactionAccount: transaction.account),
            category: map(category: transaction.category),
            linkedTransactionID: transaction.linkedTransactionID?.rawValue
        )
    }
    
    static func map(transactionAccount: TransactionAccount) -> TransactionAccountPresentation {
        return TransactionAccountPresentation(id: ID<TransactionAccountPresentation>(transactionAccount.id), name: transactionAccount.name)
    }
    
    static func map(transactionAccount: TransactionAccountPresentation) -> TransactionAccount {
        return TransactionAccount(id: ID<TransactionAccount>(transactionAccount.id), name: transactionAccount.name)
    }
    
//    static func map(payeePresentation: PayeePresentation?) -> Payee? {
//        guard let payee = payeePresentation else { return nil }
//        return Payee(
//            id: ID<Payee>(payee.id),
//            name: payee.name,
//            type: map(payeeTypePresentation: payee.type)
//        )
//    }
    
//    static func map(payeeTypePresentation: PayeeTypePresentation) -> PayeeType {
//        switch payeeTypePresentation {
//        case .regular: .regular
//        case .transfer: .transfer)
//        }
//    }
    
//    static func map(account: BudgetAccount) -> BudgetAccountPresentation {
//        return BudgetAccountPresentation(
//            id: ID<BudgetAccountPresentation>(account.id),
//            name: account.name,
//            accountType: map(accountType: account.type),
//            startingBalance: account.startingBalance.formatted(),
//            notes: account.notes,
//            isClosed: account.isClosed,
//            balance: account.balance.formatted(.currency(code: "GBP")),
//            transactionsByDate: map(transactions: account.transactions)
//        )
//    }
    
    static func map(account: AccountData) -> BudgetAccountPresentation {
        return BudgetAccountPresentation(
            id: ID<BudgetAccountPresentation>(account.id),
            name: account.name,
            accountType: map(accountType: account.type),
            startingBalance: account.startingBalance.formatted(),
            notes: account.notes,
            isClosed: account.isClosed,
            balance: account.balance.formatted(.currency(code: "GBP")),
            transactionsByDate: map(transactions: account.transactions)
        )
    }
    
    static func map(accountType: BudgetAccountType) -> BudgetAccountTypePresentation {
        switch accountType {
        case .cash(let cashAccountType):
            return .cash(map(cashAccountType: cashAccountType))
        case .credit(let creditAccountType):
            return .credit(map(creditAccountType: creditAccountType))
        }
    }
    
    static func map(cashAccountType: CashAccountType) -> CashAccountTypePresentation {
        switch cashAccountType {
        case .cash:
            return .cash
        case .checking:
            return .checking
        case .savings:
            return .savings
        }
    }
    
    static func map(creditAccountType: CreditAccountType) -> CreditAccountTypePresentation {
        switch creditAccountType {
        case .creditCard:
            return .creditCard
        }
    }
    
    static func map(transactions: [TransactionData]) -> [TransactionDate] {
        let grouped = Dictionary(grouping: transactions, by: { $0.date })
        let sorted = grouped.sorted { $0.key > $1.key }
        
        return sorted.map { date, entities in
            let mapped = entities.map { transaction in
                TransactionPresentationMapper.map(transaction: transaction)
            }
            return TransactionDate(id: .init(), date: date, transactions: mapped)
        }
    }
    
    static func map(payee: Payee?) -> PayeePresentation? {
        guard let payee else { return nil }
        return PayeePresentation(id: ID<PayeePresentation>(payee.id), name: payee.name, type: map(payeeType: payee.type))
    }
    
    static func map(category: TransactionCategory?) -> TransactionCategoryPresentation? {
        guard let category else { return nil }
        return TransactionCategoryPresentation(id: ID<TransactionCategoryPresentation>(category.id), name: category.name)
    }

    static func map(amount: Amount) -> AmountPresentation {
        switch amount {
        case .inflow(let value):
            return AmountPresentation(type: .inflow, value: value.formatted(.currency(code: "GBP")))
        case .outflow(let value):
            return AmountPresentation(type: .outflow, value: "-" + value.formatted(.currency(code: "GBP")))
        }
    }

    static func map(amount: Amount) -> AmountDraft {
        switch amount {
        case .inflow(let value):
            return AmountDraft(type: .inflow, value: value.formatted(.currency(code: "GBP")))
        case .outflow(let value):
            return AmountDraft(type: .outflow, value: "-" + value.formatted(.currency(code: "GBP")))
        }
    }
    
//    static func map(transactionDraft: TransactionDraft) -> BudgetTransaction {
//        return BudgetTransaction(
//            id: ID<BudgetTransaction>(transactionDraft.id),
//            date: transactionDraft.date,
//            memo: transactionDraft.memo,
//            amount: map(amountRequest: transactionDraft.amount),
//            isCleared: transactionDraft.isCleared,
//            payee: TransactionPresentationMapper.map(payeePresentation: transactionDraft.payee),
//            category: TransactionCategory(id: ID<TransactionCategory>(transactionDraft.category?.id) ?? .init(), name: transactionDraft.category?.name ?? ""), // TODO: Map this from somewhere and deal with blank string
//            account: TransactionPresentationMapper.map(transactionAccount: transactionDraft.account!), // TODO: Deal with force unwrapping
//            linkedTransactionID: ID<BudgetTransaction>(transactionDraft.id)
//        )
//    }
    
    // TODO: Check this correct with positive, negative values, errors go somewhere
    // TODO: Also I wrote a function like this in a view or view model which needs to be deleted
    static func map(amountRequest: AmountDraft) -> Amount {
        switch amountRequest.type {
        case .inflow:
            if let value = amountRequest.value.decimalValue {
                return .inflow(value)
            }
        case .outflow:
            if let value = amountRequest.value.decimalValue  {
                return .outflow(value)
            }
        }
        return .outflow(0.00) // TODO: Deal with this, should not be here
    }
    
    static func map(payeeType: PayeeType) -> PayeeTypePresentation {
        switch payeeType {
        case .regular: .regular
        case .transfer(let accountID): .transfer(ID<BudgetAccountPresentation>(accountID))
        }
    }
}


enum DecimalError: Error {
    case failedToMakeDecimal
}
