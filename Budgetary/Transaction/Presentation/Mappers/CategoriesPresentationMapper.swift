//
//  CategoriesPresentationMapper.swift
//  Budgetary
//
//  Created by Phillip Baker on 10/05/2025.
//

import Foundation

public final class CategoriesPresentationMapper {
    func map(categoryGroupRows: [CategoryGroupRow]) -> [CategoryGroupNamePresentation] {
        return categoryGroupRows.map { groupRow in
            map(categoryGroupRow: groupRow)
        }
    }
    
    func map(categoryGroupRow: CategoryGroupRow) -> CategoryGroupNamePresentation {
        return CategoryGroupNamePresentation(
            id: ID<CategoryGroupNamePresentation>(categoryGroupRow.id),
            name: categoryGroupRow.name
        )
    }
    
    func map(categoryGroupRows: [CategoryGroupRow]) -> [CategoryNamePresentation] {
        var categoryNames: [CategoryNamePresentation] = []
        
        for group in categoryGroupRows {
            categoryNames.append(contentsOf: map(categories: group.categories, for: group))
        }
        return categoryNames
    }

    func map(categoryGroups: [CategoryGroup]) -> [CategoryNamePresentation] {
        var categoryNames: [CategoryNamePresentation] = []
        
        for group in categoryGroups {
            categoryNames.append(contentsOf: map(categories: group.categories, for: group))
        }
        return categoryNames
    }

    // TODO: mae sure hidden categories/groups are filtered out and can prob remove isHiiden again since this is ready only nad doersnt get mapped back. can i remove nything else too?
    func map(categories: [Category], for group: CategoryGroup) -> [CategoryNamePresentation] {
        let grouped = Dictionary(grouping: categories, by: { $0.name.prefix(1) })
        let sorted = grouped.sorted { $0.key < $1.key }
        
        return sorted.map { letter, categories in
            let mapped = categories.map { category in
                map(category: category)
            }
            return CategoryNamePresentation(
                id: ID<CategoryNamePresentation>(UUID(uuidString: String(letter)) ?? UUID()),
                letter: String(letter),
                isHidden: group.isHidden,
                group: map(categoryGroup: group),
                categories: mapped.sorted { $0.name < $1.name }
            )
        }
    }
    
    func map(categories: [CategoryRow], for group: CategoryGroupRow) -> [CategoryNamePresentation] {
        let grouped = Dictionary(grouping: categories, by: { $0.name.prefix(1) })
        let sorted = grouped.sorted { $0.key < $1.key }
        
        return sorted.map { letter, categories in
            let mapped = categories.map { category in
                map(category: category)
            }
            return CategoryNamePresentation(
                id: ID<CategoryNamePresentation>(UUID(uuidString: String(letter)) ?? UUID()),
                letter: String(letter),
                isHidden: group.isHidden,
                group: map(categoryGroup: group),
                categories: mapped.sorted { $0.name < $1.name }
            )
        }
    }
    
    func map(categoryGroup: CategoryGroup) -> CategoryGroupNamePresentation {
        return CategoryGroupNamePresentation(id: ID<CategoryGroupNamePresentation>(categoryGroup.id), name: categoryGroup.name)
    }
    
    func map(categoryGroup: CategoryGroupRow) -> CategoryGroupNamePresentation {
        return CategoryGroupNamePresentation(id: ID<CategoryGroupNamePresentation>(categoryGroup.id), name: categoryGroup.name)
    }
    
    func map(category: Category) -> TransactionCategoryPresentation {
        return TransactionCategoryPresentation(id: ID<TransactionCategoryPresentation>(category.id), name: category.name)
    }
    
    func map(category: CategoryRow) -> TransactionCategoryPresentation {
        return TransactionCategoryPresentation(id: ID<TransactionCategoryPresentation>(category.id), name: category.name)
    }
}
