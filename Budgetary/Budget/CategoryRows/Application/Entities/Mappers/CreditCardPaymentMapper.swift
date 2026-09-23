//
//  CreditCardPaymentMapper.swift
//  Budgetary
//
//  Created by Phillip Baker on 10/12/2025.
//

enum CreditCardPaymentMapper {
    // MARK: - Credit Card Payments Plain -> Entity
    
    static func map(creditCardPaymentGroupPlain: CreditCardPaymentGroupPlain) -> CreditCardPaymentGroup {
        return CreditCardPaymentGroup(
            id: ID<CreditCardPaymentGroup>(creditCardPaymentGroupPlain.id),
            name: creditCardPaymentGroupPlain.name,
            creditCardPayments: map(creditCardPaymentsPlain: creditCardPaymentGroupPlain.cardPayments)
        )
    }
    
    static func map(creditCardPaymentsPlain: [CreditCardPaymentPlain]) -> [CreditCardPayment] {
        creditCardPaymentsPlain.map { paymentPlain in
            map(creditCardPaymentPlain: paymentPlain)
        }
    }
    
    static func map(creditCardPaymentPlain: CreditCardPaymentPlain) -> CreditCardPayment {
        return CreditCardPayment(
            id: ID<CreditCardPayment>(creditCardPaymentPlain.id),
            name: creditCardPaymentPlain.name,
            isHidden: creditCardPaymentPlain.isHidden,
            assigned: creditCardPaymentPlain.assigned,
            accountID: creditCardPaymentPlain.accountID
        )
    }
    
    // MARK: - Credit Card Payments Entity -> Plain
    
    static func map(creditCardPaymentGroup: CreditCardPaymentGroup) -> CreditCardPaymentGroupPlain {
        return CreditCardPaymentGroupPlain(
            id: ID<CreditCardPaymentGroupPlain>(creditCardPaymentGroup.id),
            name: creditCardPaymentGroup.name,
            cardPayments: map(creditCardPayments: creditCardPaymentGroup.creditCardPayments)
        )
    }
    
    static func map(creditCardPayments: [CreditCardPayment]) -> [CreditCardPaymentPlain] {
        creditCardPayments.map { payment in
            map(creditCardPayment: payment)
        }
    }
    
    static func map(creditCardPayment: CreditCardPayment) -> CreditCardPaymentPlain {
        return CreditCardPaymentPlain(
            id: ID<CreditCardPaymentPlain>(creditCardPayment.id),
            name: creditCardPayment.name,
            isHidden: creditCardPayment.isHidden,
            assigned: creditCardPayment.assigned,
            accountID: creditCardPayment.accountID
        )
    }
}
