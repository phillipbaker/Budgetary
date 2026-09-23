//
//  AssignMoneyDataSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 15/02/2025.
//

import Factory
import Foundation

public final class AssignMoneyDataSource: AssignMoneySource {
    let categoryGroupsDataSourceLocal: any CategoryGroupsDataSourceLocal = Container.shared.categoryGroupsDataSourceLocal()
    let creditCardPaymentGroupDataSourceLocal: any CreditCardPaymentGroupDataSourceLocal = Container.shared.creditCardPaymentGroupDataSourceLocal()
    
    public func findCategoryGroup(containing categoryID: ID<CategoryPlain>) async -> CategoryGroupPlain? {
        await categoryGroupsDataSourceLocal.findCategoryGroup(containing: categoryID)
    }
    
    public func update(categoryGroup: CategoryGroupPlain) async {
        await categoryGroupsDataSourceLocal.update(categoryGroup: categoryGroup)
    }
    
    public func creditCardPaymentGroup() async -> CreditCardPaymentGroupPlain? {
        await creditCardPaymentGroupDataSourceLocal.creditCardPaymentGroup()
    }
    
    public func update(creditCardPaymentGroup: CreditCardPaymentGroupPlain) async {
        await creditCardPaymentGroupDataSourceLocal.update(creditCardPaymentGroup: creditCardPaymentGroup)
    }
}
