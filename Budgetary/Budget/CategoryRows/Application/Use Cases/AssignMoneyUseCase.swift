//
//  AssignMoneyUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 14/02/2025.
//

import Factory
import Foundation

struct AssignMoneyUseCase: Sendable {
    private let source: AssignMoneySource
    private let mapper: BudgetMapper
    
    init(
        source: AssignMoneySource = Container.shared.assignMoneySource(),
        mapper: BudgetMapper = Container.shared.budgetMapper()
    ) {
        self.source = source
        self.mapper = mapper
    }
    
    func execute(_ assignedAmount: Decimal, for categoryID: BudgetRowID, in monthYear: MonthYear) async throws {
        if let categoryGroupPlain = await source.findCategoryGroup(containing: ID<CategoryPlain>(categoryID)) {
            let categoryGroup = mapper.map(categoryGroupPlain: categoryGroupPlain)
            if let category = categoryGroup.categories.first(where: { $0.id == ID<Category>(categoryID) }) {
                let updatedCategory = category.updating(assignedAmount: assignedAmount, for: monthYear)
                let updatedGroup = categoryGroup.replacing(updatedCategory)
                await source.update(categoryGroup: mapper.map(categoryGroup: updatedGroup))
                return
            }
        }
        
        if let creditCardPaymentGroupPlain = await source.creditCardPaymentGroup() {
            let creditCardPaymentGroup = mapper.map(creditCardPaymentGroupPlain: creditCardPaymentGroupPlain)
            if let creditCardPayment = creditCardPaymentGroup.creditCardPayments.first(where: { $0.id == ID<CreditCardPayment>(categoryID) }) {
                let updatedCreditCardPayment = creditCardPayment.updating(assignedAmount: assignedAmount, for: monthYear)
                let updatedCreditCardPaymentGroup = creditCardPaymentGroup.replacing(updatedCreditCardPayment)
                await source.update(creditCardPaymentGroup: mapper.map(creditCardPaymentGroup: updatedCreditCardPaymentGroup))
                return
            }
        }
        
        print("Assign Money Use Case: Neither Category Not Credit Card Payment Found")
        throw BudgetError.dataError
    }
}
