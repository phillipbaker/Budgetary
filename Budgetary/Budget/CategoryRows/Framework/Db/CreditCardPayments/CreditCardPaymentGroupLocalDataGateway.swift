//
//  CreditCardPaymentGroupLocalDataGateway.swift
//  Budgetary
//
//  Created by Phillip Baker on 27/11/2025.
//

import Factory

actor CreditCardPaymentGroupLocalDataGateway: CreditCardPaymentGroupDataSourceLocal {
    let dao: CreditCardPaymentGroupDao = Container.shared.creditCardPaymentGroupDao()
    let mapper: CreditCardPaymentGroupMapperPlain = Container.shared.creditCardGroupMapperPlain()

    func loadCreditCardPaymentGroup() -> CreditCardPaymentGroupPlain {
        let creditCardPaymentGroupDb = dao.loadCreditCardPaymentGroup()
        return mapper.mapDbToPlain(creditCardPaymentGroupDb: creditCardPaymentGroupDb)
    }

    func update(creditCardPaymentGroup: CreditCardPaymentGroupPlain) {
        dao.update(creditCardPaymentGroup: mapper.mapPlainToDb(creditCardPaymentGroup: creditCardPaymentGroup))
    }
}
