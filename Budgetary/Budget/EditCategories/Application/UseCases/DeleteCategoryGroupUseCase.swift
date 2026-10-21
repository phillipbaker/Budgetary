//
//  DeleteCategoryGroupUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

import Factory

final class DeleteCategoryGroupUseCase {
    var source: DeleteCategoryGroupSource = Container.shared.deleteCategoryGroupSource()
    var mapper: BudgetMapper = Container.shared.budgetMapper()

    func execute(for id: ID<CategoryGroupPresentation>) async {
        guard let group = await source.findCategoryGroup(by: ID<CategoryGroupPlain>(id)) else {
            //throw error
            print("no group found")
            return
        }

        await source.delete(categoryGroup: group)
    }
}
