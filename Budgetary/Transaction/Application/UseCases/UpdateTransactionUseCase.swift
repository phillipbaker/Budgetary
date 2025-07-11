//
//  UpdateTransactionUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 26/05/2025.
//

import Factory

final class UpdateTransactionUseCase {
    let source: UpdateTransactionSource = Container.shared.updateTransactionSource()
    let mapper: BudgetAccountsMapper = Container.shared.budgetAccountsMapper()
    
    func update(transaction: TransactionRequestModel) async {
        // guard anything else here?
        guard let transactionId = transaction.id else { return }
        
        let payees = await source.allPayees()
        let categoryGroups = await source.allCategoryGroups()

        guard let accountId = transaction.account?.id else { return }
        guard let accountPlain = await source.findAccount(by: accountId) else { return }
        
        let account = mapper.map(
            account: accountPlain,
            fromPayees: payees,
            andCategoryGroups: categoryGroups
        )

        guard let transaction = account.transactions.first(where: { $0.id == transactionId }) else { return }
        let updatedAccount = account.updating(transaction: transaction)
        await source.update(account: mapper.map(account: updatedAccount))
    }
}
