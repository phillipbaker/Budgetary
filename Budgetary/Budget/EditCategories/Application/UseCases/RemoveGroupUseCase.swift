//
//  RemoveGroupUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

import Factory

final class RemoveGroupUseCase {
    var source: RemoveGroupSource = Container.shared.removeGroupSource()
    var mapper: BudgetMapper = Container.shared.budgetMapper()

    func removeGroup(id: ID<CategoryGroupPresentation>) async {
        guard let group = await source.findCategoryGroup(by: ID<CategoryGroupPlain>(id)) else {
            //throw error
            print("no group found")
            return
        }

        await source.remove(categoryGroup: group)
    }
}
