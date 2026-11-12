//
//  DeleteCategoryUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

import Factory

final class DeleteCategoryUseCase {
    var source: DeleteCategorySource = Container.shared.deleteCategorySource()
    var mapper: BudgetMapper = Container.shared.budgetMapper()

    // TODO: not using groupID here?
    func execute(for categoryID: ID<EditableCategoryPresentation>, from groupID: ID<CategoryGroupPresentation>) async {
        guard let containingGroup = await source.findCategoryGroup(containing: ID<CategoryPlain>(categoryID)) else {
            // TODO: throw error
            return
        }
        
        guard containingGroup.kind != .inflow else {
            // TODO: throw error
            return
        }
        
        let updatedGroup = CategoryGroupPlain(
            id: containingGroup.id,
            name: containingGroup.name,
            kind: containingGroup.kind,
            isHidden: containingGroup.isHidden,
            categories: containingGroup.categories.filter { $0.id != ID<CategoryPlain>(categoryID) }
        )
        
        await source.update(categoryGroup: updatedGroup)
    }
}
