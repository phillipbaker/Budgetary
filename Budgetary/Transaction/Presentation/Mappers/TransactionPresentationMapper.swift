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
        let sortedTransactions = transactions.sorted { $0.date > $1.date }
        let calendar = Calendar.current
        let grouped = Dictionary(grouping: sortedTransactions) { calendar.startOfDay(for: $0.date) }
        
        return grouped
            .sorted { $0.key > $1.key }
            .map { day, transactions in
                TransactionDate(
                    date: day,
                    transactions: transactions.map { TransactionPresentationMapper.map(transaction: $0) }
                )
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
    
    // TODO: Check this correct with positive, negative values, errors go somewhere
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
