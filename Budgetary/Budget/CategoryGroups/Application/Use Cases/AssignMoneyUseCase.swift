//
//  AssignMoney.swift
//  Budgetary
//
//  Created by Phillip Baker on 14/02/2025.
//

import Factory
import Foundation

public final class AssignMoney {
    let source: AssignMoneySource = Container.shared.assignMoneySource()
    let mapper: BudgetMapper = Container.shared.budgetMapper()

    private static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter
    }()
    
    func update(assignedValue: String, to categoryId: String, for monthYear: MonthYear) async {
        print("updateAssignedValue Use Case")
        guard let decimalValue = Self.formatter.number(from: assignedValue)?.decimalValue else {
            // throw error user can see here....
            print("→ Application: Error - AssignMoneyUseCase failed to make decimal")
            return
        }
        
        guard let categoryGroupPlain = await source.findCategoryGroup(containing: categoryId) else {
            // throw error user can see here...
            print("→ Application: Error - AssignMoneyUseCase failed to find category")
            return
        }
        
        guard let categoryPlain = categoryGroupPlain.categories.first(where: { $0.id == categoryId }) else { return }

        let updatedCategory = CategoryPlain(
            id: categoryPlain.id,
            name: categoryPlain.name,
            notes: categoryPlain.notes,
            isHidden: categoryPlain.isHidden,
            assigned: categoryPlain.assigned.merging([monthYear: decimalValue]) { _, new in new }
        )
        
        let updatedCategories = categoryGroupPlain.categories.map { category in
            category.id == updatedCategory.id ? updatedCategory : category
        }

        let updatedGroup = CategoryGroupPlain(
            id: categoryGroupPlain.id,
            name: categoryGroupPlain.name,
            isHidden: categoryGroupPlain.isHidden,
            categories: updatedCategories
        )
        
        await source.update(categoryGroup: updatedGroup)
    }
}
