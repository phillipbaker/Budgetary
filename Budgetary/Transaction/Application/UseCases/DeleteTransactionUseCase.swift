//
//  DeleteTransactionUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 26/05/2025.
//

import Factory

final class DeleteTransactionUseCase {
    let source: DeleteTransactionSource = Container.shared.deleteTransactionSource()
    let mapper: BudgetAccountsMapper = Container.shared.budgetAccountsMapper()
    
    func execute(for id: ID<TransactionPresentation>) async {
        let payees = await source.loadPayees()
        let accounts = await source.loadBudgetAccounts()
        let categoryGroups = await source.loadCategoryGroups()

        guard let accountPlain = accounts.first(where: { $0.transactions.contains(where: { $0.id == ID<TransactionPlain>(id) }) }) else { return }
        
        let account = mapper.map(
            account: accountPlain,
            fromPayees: payees,
            andCategoryGroups: categoryGroups
        )
        
        guard let transaction = account.transactions.first(where: { $0.id == ID<BudgetTransaction>(id) }) else { return }
        let updatedAccount = account.deleting(transactionID: transaction.id)
        await source.update(account: mapper.map(account: updatedAccount))
    }
}
