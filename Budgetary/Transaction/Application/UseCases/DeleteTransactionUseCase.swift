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
    
    func deleteTransaction(id: String) async {
        let payees = await source.allPayees()
        let accounts = await source.allAccounts()
        let categoryGroups = await source.allCategoryGroups()

        guard let accountPlain = accounts.first(where: { $0.transactions.contains(where: { $0.id == id }) }) else { return }
        
        let account = mapper.map(
            account: accountPlain,
            fromPayees: payees,
            andCategoryGroups: categoryGroups
        )
        
        guard let transaction = account.transactions.first(where: { $0.id == id }) else { return }
        let updatedAccount = account.deleting(transaction: transaction)
        await source.update(account: mapper.map(account: updatedAccount))
    }
}
