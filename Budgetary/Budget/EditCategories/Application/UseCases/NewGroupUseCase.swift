//
//  NewGroupUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

import Factory
import Foundation

final class NewGroupUseCase {
    let source: NewGroupSource = Container.shared.newGroupSource()
    let mapper: BudgetMapper = Container.shared.budgetMapper()
    
    func addNew(group name: String) async {
        let newGroup = CategoryGroup(
            id: UUID().uuidString,
            name: name,
            isHidden: false,
            assignedTotal: [:],
            activityTotal: [:],
            availableTotal: [:],
            categories: []
        )
        await source.addNew(categoryGroup: mapper.map(categoryGroup: newGroup))
    }
}
