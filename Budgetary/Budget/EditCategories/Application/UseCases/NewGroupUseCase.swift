//
//  NewGroupUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

import Factory
import Foundation

final class NewGroupUseCase: Sendable {
    let source: NewGroupSource = Container.shared.newGroupSource()
    let mapper: BudgetMapper = Container.shared.budgetMapper()
    
    func execute(for name: String) async {
        let newGroup = CategoryGroup(
            id: .init(),
            name: name,
            isHidden: false,
            categories: []
        )
        await source.addNew(categoryGroup: mapper.map(categoryGroup: newGroup))
    }
}
