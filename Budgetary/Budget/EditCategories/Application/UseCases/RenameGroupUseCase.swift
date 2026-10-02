//
//  RenameGroupUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

import Factory

final class RenameGroupUseCase {
    let source: RenameGroupSource = Container.shared.renameGroupSource()
    let mapper: EditCategoriesMapper = Container.shared.editCategoriesMapper()

    
    func rename(categoryGroupWithID id: ID<CategoryGroupPresentation>, to newName: String) async {
        guard let categoryGroupPlain = await source.findCategoryGroup(by: ID<CategoryGroupPlain>(id)) else {
            print("no category group containing category found")
            return
        }
        
        let renamedGroup = CategoryGroupPlain(
            id: categoryGroupPlain.id,
            name: newName,
            isHidden: categoryGroupPlain.isHidden,
            categories: categoryGroupPlain.categories
        )
        
        await source.update(categoryGroup: renamedGroup)
    }
}
