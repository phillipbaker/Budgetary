//
//  AccountsMapper.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/05/2025.
//

public final class BudgetAccountsMapper: Sendable {
    func mapAccounts(from data: CombinedAccountsData) -> [BudgetAccount] {
        data.accounts.map { account in
            TransactionMapper.map(account: account, fromPayees: data.payees, andCategoryGroups: data.categoryGroups)
        }
    }
    
    func map(accounts: [BudgetAccountPlain]) -> [TransactionAccount] {
        accounts.map { account in
            map(account: account)
        }
    }
    
    func map(account: BudgetAccountPlain) -> TransactionAccount {
        return TransactionAccount(id: account.id, name: account.name)
    }

    func map(transactionAccountPlain: TransactionAccountPresentation) -> TransactionAccount {
        return TransactionAccount(id: transactionAccountPlain.id, name: transactionAccountPlain.name)
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
            id: account.id,
            name: account.name,
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
            memo: transaction.memo,
            amount: transaction.amount,
            isCleared: transaction.isCleared,
            payeeId: transaction.payee?.id,
            categoryId: transaction.category?.id
        )
    }

    func map(transactionType: TransactionType, and amount: String) -> Amount {
        switch transactionType {
        case .outflow:
            // strip the leading "-" sign from string to save .outflow(Decimal)
            return .outflow(abs(amount.decimalValue))
        case .inflow:
            return .inflow(amount.decimalValue)
        }
    }
}
