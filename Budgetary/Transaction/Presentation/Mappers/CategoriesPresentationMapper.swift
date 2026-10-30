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
        let categories = categoryGroupRows
            .filter { !$0.isHidden }
            .flatMap(\.categories)
            .filter { !$0.isHidden }

        let grouped = Dictionary(grouping: categories, by: { $0.name.sectionLetter })
        
        let sections = grouped.sorted { lhs, rhs in
            switch (lhs.key, rhs.key) {
            case ("#", _): true
            case (_, "#"): false
            default: lhs.key < rhs.key
            }
        }
        
        return sections.map { letter, categories in
            let mapped = categories.map { category in
                TransactionCategoryPresentation(id: ID<TransactionCategoryPresentation>(category.id), name: category.name)
            }
            return CategoryNamePresentation(
                letter: letter,
                categories: mapped.sorted { $0.name.localizedStandardCompare($1.name) == .orderedAscending }
            )
        }
    }
}
