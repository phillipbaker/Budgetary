//
//  AssignValueSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 14/02/2025.
//

public protocol AssignMoneySource: Sendable {
    func findCategoryGroup(containing categoryID: ID<CategoryPlain>) async -> CategoryGroupPlain?
    func creditCardPaymentGroup() async -> CreditCardPaymentGroupPlain?
    func update(categoryGroup: CategoryGroupPlain) async
    func update(creditCardPaymentGroup: CreditCardPaymentGroupPlain) async
}
