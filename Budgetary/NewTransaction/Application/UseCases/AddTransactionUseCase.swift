//
//  AddTransactionUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 21/05/2025.
//

import Factory

final class AddTransactionUseCase {
    let source: AddTransactionSource = Container.shared.addTransactionSource()
    let mapper: BudgetAccountsMapper = Container.shared.budgetAccountsMapper()
    
    func execute(request: AddTransactionRequestModel) async {
        let payeesPlain = await source.getPayees()
        let accountsPlain = await source.getAccounts()
        let categoryGroupsPlain = await source.getCategoryGroups()

        guard let selectedAccountPlain = accountsPlain.first(where: { $0.id == request.accountId }) else { return }
        
        let account = mapper.map(account: selectedAccountPlain, fromPayees: payeesPlain, andCategoryGroups: categoryGroupsPlain)

        guard let categoryPlain = (
            categoryGroupsPlain
                .flatMap { $0.categories } // [CategoryPlain]
                .first(where: { $0.id == request.categoryId }) // CategoryPlain
        ) else {
            return
        }
        
        guard let payeePlain = payeesPlain.first(where: { $0.id == request.payeeId }) else { return }
        
        var amount: Amount {
            switch request.transactionType {
            case .outflow:
                // strip the leading "-" sign from string to save .outflow(Decimal)
                return .outflow(abs(request.amount.decimalValue))
            case .inflow:
                return .inflow(request.amount.decimalValue)
            }
        }

        let transaction: TransactionEntity = .init(
            date: request.date,
            payee: TransactionMapper.map(payeePlain: payeePlain, categoryGroups: categoryGroupsPlain),
            category: TransactionMapper.map(categoryPlain: categoryPlain),
            amount: amount,
            isCleared: request.isCleared
        )
        
        let updatedAccount = account.adding(transaction: transaction) 
        await source.update(account: mapper.map(account: updatedAccount))
    }
}
