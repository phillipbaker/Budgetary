//
//  TransactionPresentationMapper.swift
//  Budgetary
//
//  Created by Phillip Baker on 22/05/2025.
//

import Foundation

enum TransactionPresentationMapper {    
    static func map(transaction: TransactionEntity) -> TransactionPresentation {
        return TransactionPresentation(
            id: transaction.id,
            date: transaction.date.startOfDay(),
            memo: transaction.memo,
            amount: map(amount: transaction.amount),
            isCleared: transaction.isCleared,
            payee: map(payee: transaction.payee),
            category: map(category: transaction.category),
            account: map(transactionAccount: transaction.account)
        )
    }
    
    static func map(transactionAccount: TransactionAccount) -> TransactionAccountPresentation {
        return TransactionAccountPresentation(id: transactionAccount.id, name: transactionAccount.name)
    }
    
    static func map(account: BudgetAccount) -> BudgetAccountPresentation {
        return BudgetAccountPresentation(
            id: account.id,
            name: account.name,
            startingBalance: account.startingBalance.formatted(),
            notes: account.notes,
            isClosed: account.isClosed,
            balance: account.balance.formatted(.currency(code: "GBP")),
            transactionsByDate: map(transactions: account.transactions)
        )
    }
    
    static func map(transactions: [TransactionEntity]) -> [TransactionDate] {
        let grouped = Dictionary(grouping: transactions, by: { $0.date })
        let sorted = grouped.sorted { $0.key > $1.key }
        
        return sorted.map { date, entities in
            let mapped = entities.map { transaction in
                TransactionPresentationMapper.map(transaction: transaction)
            }
            return TransactionDate(id: UUID().uuidString, date: date, transactions: mapped)
        }
    }
    
    static func map(payee: Payee?) -> PayeePresentation? {
        guard let payee else { return nil }
        return PayeePresentation(id: payee.id, name: payee.name)
    }
    
    static func map(category: TransactionCategory?) -> TransactionCategoryPresentation? {
        guard let category else { return nil }
        return TransactionCategoryPresentation(id: category.id, name: category.name)
    }

    static func map(amount: Amount) -> AmountPresentation {
        switch amount {
        case .inflow(let value):
            return AmountPresentation(transactionType: .inflow, value: value.formatted(.currency(code: "GBP")))
        case .outflow(let value):
            return AmountPresentation(transactionType: .outflow, value: "-" + value.formatted(.currency(code: "GBP")))
        }
    }
}
