//
//  CreateBudgetAccountUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 28/11/2025.
//

import Factory
import Foundation

struct CreateBudgetAccountUseCase: Sendable {
    private let source: CreateBudgetAccountSource
    private let mapper: BudgetAccountsMapper
    
    init(
        source: CreateBudgetAccountSource = Container.shared.createBudgetAccountSource(),
        mapper: BudgetAccountsMapper = Container.shared.budgetAccountsMapper()
    ) {
        self.source = source
        self.mapper = mapper
    }
    
    func execute(name: String, accountType: BudgetAccountType, startingBalance: Decimal) async {
        // Create account
        let newAccount = BudgetAccount(id: ID<BudgetAccount>.init(), name: name, type: accountType)
        await source.create(account: mapper.map(account: newAccount))
        
        // Create transfer payee
        let newAccountPayee = Payee.transfer(name: name, accountID: newAccount.id)
        await source.create(payee: mapper.map(payee: newAccountPayee))
        
        // If credit card, add credit card payment to budget
        if newAccount.type == .credit(.creditCard) {
            let creditCardPaymentGroup = mapper.map(creditCardPaymentGroupPlain: await source.loadCreditCardPaymentGroup())
            let newCardPayment = CreditCardPayment(id: ID<CreditCardPayment>.init(), name: newAccount.name, accountID: newAccount.id.rawValue)
            let updatedCreditCardPaymentGroup = creditCardPaymentGroup.appending(newCardPayment)
            await source.update(creditCardPaymentGroup: mapper.map(creditCardPaymentGroup: updatedCreditCardPaymentGroup))
        }
    }
}
