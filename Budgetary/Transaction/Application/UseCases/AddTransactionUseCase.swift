//
//  AddTransactionUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 21/05/2025.
//

import Factory
import Foundation

final class AddTransactionUseCase {
    let source: AddTransactionSource = Container.shared.addTransactionSource()
    let mapper: BudgetAccountsMapper = Container.shared.budgetAccountsMapper()
    
    func add(transaction: TransactionRequestModel) async {
        let categoryGroups = await source.allCategoryGroups()
        let payees = await source.allPayees()

        guard let payeePresentation = transaction.payee else { return }
        guard let payeePlain = await source.findPayee(by: payeePresentation.id) else { return }
        let payee = mapper.map(payeePlain: payeePlain, categoryGroups: categoryGroups)
        
        guard let transactionCategory = transaction.category else { return }
        guard let categoryGroupPlain = await source.findCategoryGroup(containing: transactionCategory.id) else { return }
        guard let categoryPlain = categoryGroupPlain.categories.first(where: { $0.id == transactionCategory.id }) else { return }
        let category = mapper.map(categoryPlain: categoryPlain)
        
        guard let transactionAccount = transaction.account else { return }
        guard let accountPlain = await source.findBudgetAccount(by: transactionAccount .id) else { return }

        let account = mapper.map(account: accountPlain, fromPayees: payees, andCategoryGroups: categoryGroups)

        let transaction = TransactionEntity(
            id: UUID().uuidString,
            date: transaction.date,
            memo: transaction.memo,
            amount: mapper.map(transactionType: transaction.transactionType, and: transaction.amount),
            isCleared: transaction.isCleared,
            payee: payee,
            category: category,
            account: TransactionAccount(id: transactionAccount.id, name: transactionAccount.name)
        )
        
        let updatedAccount = account.adding(transaction: transaction) 
        await source.update(account: mapper.map(account: updatedAccount))
    }
}
