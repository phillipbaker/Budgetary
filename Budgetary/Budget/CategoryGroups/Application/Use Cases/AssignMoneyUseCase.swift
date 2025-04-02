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
        guard let decimalValue = Self.formatter.number(from: assignedValue)?.decimalValue else {
            // throw error user can see here....
            print("→ Application: Error - AssignMoneyUseCase failed to make decimal")
            return
        }
        
        guard let categoryPlain = await source.findCategory(by: categoryId) else {
            // throw error user can see here...
            print("→ Application: Error - AssignMoneyUseCase failed to find category")
            return
        }

        let updatedCategory = CategoryPlain(
            id: categoryPlain.id,
            name: categoryPlain.name,
            notes: categoryPlain.notes,
            isHidden: categoryPlain.isHidden,
            assigned: categoryPlain.assigned.merging([monthYear: decimalValue]) { _, new in new }
        )
        
        await source.update(category: updatedCategory)
    }
}
