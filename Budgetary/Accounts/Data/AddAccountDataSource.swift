//
//  AddAccountDataSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 28/11/2025.
//

import Factory

public final class AddAccountDataSource: AddBudgetAccountSource {
    let budgetAccountsDataSourceLocal: any BudgetAccountsDataSourceLocal = Container.shared.budgetAccountsDataSourceLocal()
    let creditCardPaymentDataSourceLocal: any CreditCardPaymentGroupDataSourceLocal = Container.shared.creditCardPaymentGroupDataSourceLocal()
    let payeesDataSourceLocal: any PayeesDataSourceLocal = Container.shared.payeesDataSourceLocal()
    
    public func add(account: BudgetAccountPlain) async {
        await budgetAccountsDataSourceLocal.create(account: account)
    }

    public func add(payee: PayeePlain) async {
        await payeesDataSourceLocal.create(payee: payee)
    }
    
    public func creditCardPaymentGroup() async -> CreditCardPaymentGroupPlain {
        await creditCardPaymentDataSourceLocal.creditCardPaymentGroup()
    }
    
    public func update(creditCardPaymentGroup: CreditCardPaymentGroupPlain) async {
        await creditCardPaymentDataSourceLocal.update(creditCardPaymentGroup: creditCardPaymentGroup)
    }
}
