//
//  CreditCardPaymentMapperPlain.swift
//  Budgetary
//
//  Created by Phillip Baker on 27/11/2025.
//

final class CreditCardPaymentGroupMapperPlain {
    func mapDbToPlain(creditCardPaymentGroupDb: CreditCardPaymentGroupDb) -> CreditCardPaymentGroupPlain {
        return CreditCardPaymentGroupPlain(
            id: ID<CreditCardPaymentGroupPlain>(creditCardPaymentGroupDb.externalID),
            name: creditCardPaymentGroupDb.name,
            cardPayments: map(creditCardPayments: creditCardPaymentGroupDb.payments)
        )
    }
    
    func map(creditCardPayments: [CreditCardPaymentDb]) -> [CreditCardPaymentPlain] {
        return creditCardPayments.map { payment in
            mapDbToPlain(paymentDb: payment)
        }
    }
    
    func mapDbToPlain(paymentDb: CreditCardPaymentDb) -> CreditCardPaymentPlain {
        return CreditCardPaymentPlain(
            id: ID<CreditCardPaymentPlain>(paymentDb.externalID),
            name: paymentDb.name,
            isHidden: paymentDb.isHidden,
            assigned: paymentDb.assigned,
            accountID: paymentDb.accountID
        )
    }
    
    func mapPlainToDb(creditCardPaymentGroup: CreditCardPaymentGroupPlain) -> CreditCardPaymentGroupDb {
        return CreditCardPaymentGroupDb(
            externalID: creditCardPaymentGroup.id.rawValue,
            payments: map(creditCardPayments: creditCardPaymentGroup.cardPayments)
        )
    }
    
    func map(creditCardPayments: [CreditCardPaymentPlain]) -> [CreditCardPaymentDb] {
        return creditCardPayments.map { payment in
            mapPlainToDb(creditCardPaymentPlain: payment)
        }
    }
    
    func mapPlainToDb(creditCardPaymentPlain: CreditCardPaymentPlain) -> CreditCardPaymentDb {
        return CreditCardPaymentDb(
            externalID: creditCardPaymentPlain.id.rawValue,
            name: creditCardPaymentPlain.name,
            isHidden: creditCardPaymentPlain.isHidden,
            assigned: creditCardPaymentPlain.assigned,
            accountID: creditCardPaymentPlain.accountID
        )
    }
}
