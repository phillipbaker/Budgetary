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
        categoryGroupRows
            .filter { !$0.isHidden }
            .flatMap(\.categories)
            .filter { !$0.isHidden }
            .alphabeticalSections(by: \.name)
            .map { section in
                CategoryNamePresentation(
                    letter: section.letter,
                    categories: section.elements.map {
                        TransactionCategoryPresentation(id: ID<TransactionCategoryPresentation>($0.id), name: $0.name)
                    }
                )
            }
    }
}
