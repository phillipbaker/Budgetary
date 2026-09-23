//
//  RenameCategoryUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

import Factory

final class RenameCategoryUseCase {
    let source: RenameCategorySource = Container.shared.renameCategorySource()
    let mapper: EditCategoriesMapper = Container.shared.editCategoriesMapper()
    
     func rename(categoryWithID id: ID<EditableCategoryPresentation>, to newName: String) async {
        guard let categoryGroupPlain = await source.findCategoryGroup(containing: ID<CategoryPlain>(id)) else {
            print("no category group containing category found")
            return
        }
        
        guard let categoryPlain = categoryGroupPlain.categories.first(where: { $0.id == ID<CategoryPlain>(id) }) else {
            print("no category in returned group with id")
            return
        }
        
        let renamedCategory = CategoryPlain(
            id: categoryPlain.id,
            name: newName,
            notes: categoryPlain.notes,
            isHidden: categoryPlain.isHidden,
            assigned: categoryPlain.assigned
        )
        
        let updatedGroup = CategoryGroupPlain(
            id: categoryGroupPlain.id,
            name: categoryGroupPlain.name,
            isHidden: categoryGroupPlain.isHidden,
            categories: categoryGroupPlain.categories.map {
                $0.id == renamedCategory.id ? renamedCategory : $0
            }
        )
        
        await source.update(categoryGroup: updatedGroup)
    }
}
