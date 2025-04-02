//
//  EditCategoriesMapper.swift
//  Budgetary
//
//  Created by Phillip Baker on 01/04/2025.
//

public final class EditCategoriesMapper {
    func map(categoryGroupsPlain: [CategoryGroupPlain]) -> [EditableCategoryGroup] {
        return categoryGroupsPlain.map { categoryGroupPlain in
            map(categoryGroupPlain: categoryGroupPlain)
        }
    }
    
    func map(categoryGroupPlain: CategoryGroupPlain) -> EditableCategoryGroup {
        return EditableCategoryGroup(
            id: categoryGroupPlain.id,
            name: categoryGroupPlain.name,
            categories: map(categoriesPlain: categoryGroupPlain.categories)
        )
    }
    
    func map(categoriesPlain: [CategoryPlain]) -> [EditableCategory] {
        return categoriesPlain.map { categoryPlain in
            map(categoryPlain: categoryPlain)
        }
    }
    
    func map(categoryPlain: CategoryPlain) -> EditableCategory {
        return EditableCategory(id: categoryPlain.id, name: categoryPlain.name)
    }
}
