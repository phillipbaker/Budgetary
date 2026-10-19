//
//  CreateBudgetAccountDataSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 28/11/2025.
//

import Factory

public final class CreateBudgetAccountDataSource: CreateBudgetAccountSource {
    let budgetAccountsDataSourceLocal: any BudgetAccountsDataSourceLocal = Container.shared.budgetAccountsDataSourceLocal()
    let creditCardPaymentDataSourceLocal: any CreditCardPaymentGroupDataSourceLocal = Container.shared.creditCardPaymentGroupDataSourceLocal()
    let payeesDataSourceLocal: any PayeesDataSourceLocal = Container.shared.payeesDataSourceLocal()
    
    public func create(account: BudgetAccountPlain) async {
        await budgetAccountsDataSourceLocal.create(account: account)
    }

    public func create(payee: PayeePlain) async {
        await payeesDataSourceLocal.create(payee: payee)
    }
    
    public func loadCreditCardPaymentGroup() async -> CreditCardPaymentGroupPlain {
        await creditCardPaymentDataSourceLocal.loadCreditCardPaymentGroup()
    }
    
    public func update(creditCardPaymentGroup: CreditCardPaymentGroupPlain) async {
        await creditCardPaymentDataSourceLocal.update(creditCardPaymentGroup: creditCardPaymentGroup)
    }
}
