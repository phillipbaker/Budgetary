//
//  AddAccountUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 28/11/2025.
//

import Factory
import Foundation

struct AddAccountUseCase: Sendable {
    private let source: AddBudgetAccountSource
    private let mapper: BudgetAccountsMapper
    
    init(
        source: AddBudgetAccountSource = Container.shared.addAccountSource(),
        mapper: BudgetAccountsMapper = Container.shared.budgetAccountsMapper()
    ) {
        self.source = source
        self.mapper = mapper
    }
    
    func execute(name: String, accountType: BudgetAccountType, startingBalance: Decimal) async {
        // Add account
        let newAccount = BudgetAccount(id: ID<BudgetAccount>.init(), name: name, type: accountType)
        await source.add(account: mapper.map(account: newAccount))
        
        // Add transfer payee
        let newAccountPayee = Payee.transfer(name: name, accountID: newAccount.id)
        await source.add(payee: mapper.map(payee: newAccountPayee))
        
        // If credit card, add credit card payment to budget
        if newAccount.type == .credit(.creditCard) {
            let creditCardPaymentGroup = mapper.map(creditCardPaymentGroupPlain: await source.creditCardPaymentGroup())
            let newCardPayment = CreditCardPayment(id: ID<CreditCardPayment>.init(), name: newAccount.name, accountID: newAccount.id.rawValue)
            let updatedCreditCardPaymentGroup = creditCardPaymentGroup.appending(newCardPayment)
            await source.update(creditCardPaymentGroup: mapper.map(creditCardPaymentGroup: updatedCreditCardPaymentGroup))
        }
    }
}
