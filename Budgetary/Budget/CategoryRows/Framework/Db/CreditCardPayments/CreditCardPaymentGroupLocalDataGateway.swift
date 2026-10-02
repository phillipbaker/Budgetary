//
//  CreditCardGroupLocalDataGateway.swift
//  Budgetary
//
//  Created by Phillip Baker on 27/11/2025.
//

import Factory

actor CreditCardPaymentGroupLocalDataGateway: CreditCardPaymentGroupDataSourceLocal {
    let dao: CreditCardPaymentGroupDao = Container.shared.creditCardPaymentGroupDao()
    let mapper: CreditCardPaymentGroupMapperPlain = Container.shared.creditCardGroupMapperPlain()

    func creditCardPaymentGroup() -> CreditCardPaymentGroupPlain {
        let creditCardPaymentGroupDb = dao.creditCardPaymentGroup()
        return mapper.mapDbToPlain(creditCardPaymentGroupDb: creditCardPaymentGroupDb)
    }

    func update(creditCardPaymentGroup: CreditCardPaymentGroupPlain) {
        dao.update(creditCardPaymentGroup: mapper.mapPlainToDb(creditCardPaymentGroup: creditCardPaymentGroup))
    }
}
