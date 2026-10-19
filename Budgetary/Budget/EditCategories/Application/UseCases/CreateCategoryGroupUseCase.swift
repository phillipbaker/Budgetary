//
//  CreateCategoryGroupUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

import Factory
import Foundation

final class CreateCategoryGroupUseCase: Sendable {
    let source: CreateCategoryGroupSource = Container.shared.createCategoryGroupSource()
    let mapper: BudgetMapper = Container.shared.budgetMapper()
    
    func execute(for name: String) async {
        let newGroup = CategoryGroup(
            id: .init(),
            name: name,
            isHidden: false,
            categories: []
        )
        await source.create(categoryGroup: mapper.map(categoryGroup: newGroup))
    }
}
