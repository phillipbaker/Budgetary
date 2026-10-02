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
    
    func hide(categoryWithID categoryID: ID<CategoryRow>) async {
        guard let categoryGroup = await source.findCategoryGroup(containing: ID<CategoryPlain>(categoryID)) else {
            // TODO: throw error
            print("could not find category group matching provided id")
            return
        }
        
        guard let category = categoryGroup.categories.first(where: { $0.id == ID<CategoryPlain>(categoryID) }) else {
            // TODO: throw error
            print("could not find category matching provided id")
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
            isHidden: categoryGroup.isHidden,
            categories: categoryGroup.categories.map {
                $0.id == updatedCategory.id ? updatedCategory : $0
            }
        )
        
        await source.update(categoryGroup: updatedCategoryGroup)
    }
}
