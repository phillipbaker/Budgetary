//
//  RenameCategoryUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

import Factory

public final class RenameCategoryUseCase {
    let source: RenameCategorySource = Container.shared.renameCategorySource()
    let mapper: EditCategoriesMapper = Container.shared.editCategoriesMapper()
    
    func renameCategory(withId id: String, to newName: String) async {
        print("rename category called in use case")
        guard let categoryPlain = await source.findCategory(by: id) else {
            print("no plain category found in use case")
            return
        }

        let renamedCategory = CategoryPlain(
            id: categoryPlain.id,
            name: newName,
            notes: categoryPlain.notes,
            isHidden: categoryPlain.isHidden,
            assigned: categoryPlain.assigned
        )
        print("renamed category in use case: ", renamedCategory.name)
        await source.update(category: renamedCategory)
    }
}
