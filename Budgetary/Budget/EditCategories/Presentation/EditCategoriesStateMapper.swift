//
//  EditCategoriesStateMapper.swift
//  Budgetary
//
//  Created by Phillip Baker on 02/11/2024.
//

import Dependencies

public class EditCategoriesStateMapper {
    var mapper: BudgetPresentationMapper

    init(mapper: BudgetPresentationMapper) {
        self.mapper = mapper
    }
    
    func map(categoryGroups: [CategoryGroup]) -> EditCategoriesState {
        if categoryGroups.isEmpty {
            return EditCategoriesState.empty
        } else {
            return EditCategoriesState.success(mapper.map(categoryGroups: categoryGroups))
        }
    }
}
