//
//  HideCategoryUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 28/04/2025.
//

import Factory

final class HideCategoryUseCase {
    let source: HideCategorySource = Container.shared.hideCategorySource()
    let mapper: EditCategoriesMapper = Container.shared.editCategoriesMapper()
    
    func execute(for categoryID: ID<CategoryRow>) async {
        guard let categoryGroup = await source.findCategoryGroup(containing: ID<CategoryPlain>(categoryID)) else {
            // TODO: throw error
            return
        }
        
        guard categoryGroup.kind != .inflow else {
            // TODO: throw error
            return
        }
        
        guard let category = categoryGroup.categories.first(where: { $0.id == ID<CategoryPlain>(categoryID) }) else {
            // TODO: throw error
            return
        }
        
        let updatedCategory = CategoryPlain(
            id: category.id,
            name: category.name,
            notes: category.notes,
            isHidden: true,
            assigned: category.assigned
        )
        
        let updatedCategoryGroup = CategoryGroupPlain(
            id: categoryGroup.id,
            name: categoryGroup.name,
            kind: categoryGroup.kind,
            isHidden: categoryGroup.isHidden,
            categories: categoryGroup.categories.map {
                $0.id == updatedCategory.id ? updatedCategory : $0
            }
        )
        
        await source.update(categoryGroup: updatedCategoryGroup)
    }
}
