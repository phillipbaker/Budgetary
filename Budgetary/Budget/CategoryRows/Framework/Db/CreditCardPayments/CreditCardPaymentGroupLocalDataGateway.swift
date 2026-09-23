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
    
//    func create(creditCardPayment: CreditCardPaymentPlain) async {
//        dao.create(creditCardPayment: mapper.mapPlainToDb(creditCardPaymentPlain: creditCardPayment))
//    }

    func update(creditCardPaymentGroup: CreditCardPaymentGroupPlain) {
        dao.update(creditCardPaymentGroup: mapper.mapPlainToDb(creditCardPaymentGroup: creditCardPaymentGroup))
    }
    
//    func delete(creditCardPayment: CreditCardPaymentPlain) {
//        dao.delete(creditCardPayment: mapper.mapPlainToDb(creditCardPaymentPlain: creditCardPayment))
//    }
}
