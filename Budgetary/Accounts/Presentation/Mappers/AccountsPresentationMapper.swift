//
//  AccountsPresentationMapper.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/05/2025.
//

import Foundation
import SwiftUI

public final class AccountsPresentationMapper {
    func map(accounts: [BudgetAccount]) -> [BudgetAccountPresentation] {
        return accounts.map { account in
            map(account: account)
        }
    }
    
    func map(account: BudgetAccount) -> BudgetAccountPresentation {
        return BudgetAccountPresentation(
            id: account.id,
            name: account.nickname,
            startingBalance: account.startingBalance.formatted(),
            notes: account.notes,
            isClosed: account.isClosed,
            balance: account.balance.formatted(.currency(code: "GBP")),
            transactionsByDate: map(transactions: account.transactions)
        )
    }
    
    func map(transactions: [TransactionEntity]) -> [TransactionDate] {
        let grouped = Dictionary(grouping: transactions, by: { $0.date })
        let sorted = grouped.sorted { $0.key > $1.key }
        
        return sorted.map { date, entities in
            let mapped = entities.map { transaction in
                map(transaction: transaction)
            }
            return TransactionDate(id: UUID().uuidString, date: date, transactions: mapped)
        }
    }
    
    func map(transaction: TransactionEntity) -> TransactionPresentation {
        return TransactionPresentation(
            id: transaction.id,
            date: transaction.date.startOfDay().formatted(),
            payee: map(payee: transaction.payee),
            category: map(category: transaction.category),
            memo: transaction.memo,
            amount: map(amount: transaction.amount),
            isCleared: transaction.isCleared
        )
    }
    
    func map(payee: Payee?) -> PayeePresentation? {
        guard let payee else { return nil }
        return PayeePresentation(id: payee.id, name: payee.name)
    }
    
    func map(category: TransactionCategory?) -> TransactionCategoryPresentation? {
        guard let category else { return nil }
        return TransactionCategoryPresentation(id: category.id, name: category.name)
    }
    
    func map(amount: Amount) -> AmountPresentation {
        switch amount {
        case .inflow(let value):
            return .inflow(value.formatted(.currency(code: "GBP")))
        case .outflow(let value):
            return .outflow(value.formatted(.currency(code: "GBP")))
        }
    }
}

extension Date {
    func startOfDay() -> Date {
        Calendar.current.startOfDay(for: self)
    }
}
