//
//  EditCategoriesPresentationMapper.swift
//  Budgetary
//
//  Created by Phillip Baker on 01/04/2025.
//

public final class EditCategoriesPresentationMapper: Sendable {
    func map(editableCategoryGroups: [EditableCategoryGroup]) -> [EditableCategoryGroupPresentation] {
        return editableCategoryGroups.map { editableCategoryGroup in
            map(editableCategoryGroup: editableCategoryGroup)
        }
    }
    func map(editableCategoryGroup: EditableCategoryGroup) -> EditableCategoryGroupPresentation {
        return EditableCategoryGroupPresentation(
            id: ID<CategoryGroupPresentation>(editableCategoryGroup.id),
            name: editableCategoryGroup.name,
            categories: map(editableCategories: editableCategoryGroup.categories)
        )
    }
    
    func map(editableCategories: [EditableCategory]) -> [EditableCategoryPresentation] {
        return editableCategories.map { editableCategory in
            map(editableCategory: editableCategory)
        }
    }
    
    func map(editableCategory: EditableCategory) -> EditableCategoryPresentation {
        return EditableCategoryPresentation(id: ID<EditableCategoryPresentation>(editableCategory.id), name: editableCategory.name)
    }
}
