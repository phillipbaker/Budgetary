//
//  RenameGroupUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

//public class RenameGroupUseCase {
//    var source: RenameGroupSource
//    var mapper: BudgetMapper
//    
//    public init(source: RenameGroupSource, mapper: BudgetMapper) {
//        self.source = source
//        self.mapper = mapper
//    }
//    
//    func rename(_ group: CategoryGroupPresentation, to name: String) {
//        let group = source.findGroup(by: group.id)
//        source.rename(group, to: name)
//    }
//}

import Factory

final class RenameGroupUseCase {
    let source: RenameGroupSource = Container.shared.renameGroupSource()
    let mapper: EditCategoriesMapper = Container.shared.editCategoriesMapper()

    
    func rename(categoryGroupWithId id: String, to newName: String) async {
        guard let categoryGroupPlain = await source.findCategoryGroup(by: id) else {
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
