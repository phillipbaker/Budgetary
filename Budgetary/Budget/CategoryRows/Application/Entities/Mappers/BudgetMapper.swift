//
//  BudgetMapper.swift
//  Budgetary
//
//  Created by Phillip Baker on 10/12/2025.
//

public final class BudgetMapper: Sendable {
    // MARK: - Credit Card Payments Plain -> Entity
    
    func map(creditCardPaymentGroupPlain: CreditCardPaymentGroupPlain) -> CreditCardPaymentGroup {
        CreditCardPaymentMapper.map(creditCardPaymentGroupPlain: creditCardPaymentGroupPlain)
    }
    
    // MARK: - Credit Card Payments Entity -> Plain
    
    func map(creditCardPaymentGroup: CreditCardPaymentGroup) -> CreditCardPaymentGroupPlain {
        return CreditCardPaymentGroupPlain(
            id: ID<CreditCardPaymentGroupPlain>(creditCardPaymentGroup.id),
            name: creditCardPaymentGroup.name,
            cardPayments: map(creditCardPayments: creditCardPaymentGroup.creditCardPayments)
        )
    }
    
    func map(creditCardPayments: [CreditCardPayment]) -> [CreditCardPaymentPlain] {
        creditCardPayments.map { payment in
            map(creditCardPayment: payment)
        }
    }
    
    func map(creditCardPayment: CreditCardPayment) -> CreditCardPaymentPlain {
        CreditCardPaymentMapper.map(creditCardPayment: creditCardPayment)
    }
    
    // MARK: - CategoryGroups Plain -> Entity
    
    func map(categoryGroupsPlain: [CategoryGroupPlain]) -> [CategoryGroup] {
        categoryGroupsPlain.map { categoryGroupPlain in
            map(categoryGroupPlain: categoryGroupPlain)
        }
    }
    
    func map(categoryGroupPlain: CategoryGroupPlain) -> CategoryGroup {
        return CategoryGroup(
            id: ID<CategoryGroup>(categoryGroupPlain.id),
            name: categoryGroupPlain.name,
            isHidden: categoryGroupPlain.isHidden,
            categories: map(categoriesPlain: categoryGroupPlain.categories)
        )
    }
    
    func map(categoriesPlain: [CategoryPlain]) -> [Category] {
        categoriesPlain.map { categoryPlain in
            map(categoryPlain: categoryPlain)
        }
    }
        
    func map(categoryPlain: CategoryPlain) -> Category {
        return Category(
            id: ID<Category>(categoryPlain.id),
            name: categoryPlain.name,
            notes: categoryPlain.notes,
            isHidden: categoryPlain.isHidden,
            assigned: categoryPlain.assigned
        )
    }

    // MARK: - Category Groups Entity -> Plain
    
    func map(categoryGroups: [CategoryGroup]) -> [CategoryGroupPlain] {
        categoryGroups.map { categoryGroup in
            map(categoryGroup: categoryGroup)
        }
    }
    
    func map(categoryGroup: CategoryGroup) -> CategoryGroupPlain {
        return CategoryGroupPlain(
            id: ID<CategoryGroupPlain>(categoryGroup.id),
            name: categoryGroup.name,
            isHidden: categoryGroup.isHidden,
            categories: map(categoryEntities: categoryGroup.categories)
        )
    }
    
    func map(categoryEntities: [Category]) -> [CategoryPlain] {
        categoryEntities.map { category in
            map(category: category)
        }
    }
    
    func map(category: Category) -> CategoryPlain {
        return CategoryPlain(
            id: ID<CategoryPlain>(category.id),
            name: category.name,
            notes: category.notes,
            isHidden: category.isHidden,
            assigned: category.assigned
        )
    }
}
