//
//  RemoveCategoryUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

import Factory

final class RemoveCategoryUseCase {
    var source: RemoveCategorySource = Container.shared.removeCategorySource()
    var mapper: BudgetMapper = Container.shared.budgetMapper()

    // TODO: not suing groupID here?
    func removeCategory(categoryID: ID<EditableCategoryPresentation>, from groupID: ID<CategoryGroupPresentation>) async {
        guard let containingGroup = await source.findCategoryGroup(containing: ID<CategoryPlain>(categoryID)) else {
            print("no group found")
            return
        }
        
        let updatedGroup = CategoryGroupPlain(
            id: containingGroup.id,
            name: containingGroup.name,
            isHidden: containingGroup.isHidden,
            categories: containingGroup.categories.filter { $0.id != ID<CategoryPlain>(categoryID) }
        )
        
        await source.update(categoryGroup: updatedGroup)
    }
}
