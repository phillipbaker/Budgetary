//
//  EditCategoriesStateMapper.swift
//  Budgetary
//
//  Created by Phillip Baker on 02/11/2024.
//

import Factory

public final class EditCategoriesStateMapper {
    let mapper: EditCategoriesPresentationMapper = Container.shared.editCategoriesPresentationMapper()
    
    func map(editableCagtegoryGroups: [EditableCategoryGroup]) -> EditCategoriesState {
        if editableCagtegoryGroups.isEmpty {
            return EditCategoriesState.empty
        } else {
            return EditCategoriesState.success(mapper.map(editableCategoryGroups: editableCagtegoryGroups))
        }
    }
}
