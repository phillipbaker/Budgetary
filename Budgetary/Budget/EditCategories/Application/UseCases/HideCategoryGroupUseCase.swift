//
//  HideCategoryGroupUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 28/04/2025.
//

import Factory

final class HideCategoryGroupUseCase {
    let source: HideCategoryGroupSource = Container.shared.hideCategoryGroupSource()
    let mapper: EditCategoriesMapper = Container.shared.editCategoriesMapper()
    
    func hide(categoryGroupID: ID<CategoryGroupPresentation>) async {
        guard let categoryGroup = await source.findCategoryGroup(by: ID<CategoryGroupPlain>(categoryGroupID)) else {
            // throw error
            print("could not find category group matching provided id")
            return
        }
        
        let updatedCategoryGroup = CategoryGroupPlain(
            id: categoryGroup.id,
            name: categoryGroup.name,
            isHidden: true,
            categories: categoryGroup.categories
        )
        
        await source.update(categoryGroup: updatedCategoryGroup)
    }
}

