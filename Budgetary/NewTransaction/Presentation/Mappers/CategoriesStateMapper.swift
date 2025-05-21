//
//  CategoriesStateMapper.swift
//  Budgetary
//
//  Created by Phillip Baker on 10/05/2025.
//

import Factory

public final class CategoriesStateMapper {
    let mapper: CategoriesPresentationMapper = Container.shared.categoriesPresentationMapper()
    
    func map(categoryGroups: [CategoryGroupEntity]) -> CategoryPickerState {
        return .success(mapper.map(categoryGroups: categoryGroups))
    }
}
