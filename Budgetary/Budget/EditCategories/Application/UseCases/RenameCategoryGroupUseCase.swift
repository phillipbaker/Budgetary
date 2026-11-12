//
//  RenameCategoryGroupUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

import Factory

final class RenameCategoryGroupUseCase {
    let source: RenameCategoryGroupSource = Container.shared.renameCategoryGroupSource()
    let mapper: EditCategoriesMapper = Container.shared.editCategoriesMapper()

    
    func execute(for id: ID<CategoryGroupPresentation>, to newName: String) async {
        guard let categoryGroupPlain = await source.findCategoryGroup(by: ID<CategoryGroupPlain>(id)) else {
            print("no category group containing category found")
            return
        }
        
        guard categoryGroupPlain.kind != .inflow else {
            // throw error here
            return
        }
        
        let renamedGroup = CategoryGroupPlain(
            id: categoryGroupPlain.id,
            name: newName,
            kind: categoryGroupPlain.kind,
            isHidden: categoryGroupPlain.isHidden,
            categories: categoryGroupPlain.categories
        )
        
        await source.update(categoryGroup: renamedGroup)
    }
}
