//
//  CategoriesPresentationMapper.swift
//  Budgetary
//
//  Created by Phillip Baker on 10/05/2025.
//

import Foundation

public final class CategoriesPresentationMapper {
    func map(categoryGroups: [CategoryGroupEntity]) -> [CategoryName] {
        var categoryNames: [CategoryName] = []
        
        for group in categoryGroups {
            categoryNames.append(contentsOf: map(categories: group.categories, for: group))
        }
        
        return categoryNames
    }
    
//    func map(categoryGroups: [CategoryGroup]) -> [CategoryName] {
//        categoryGroups.flatMap { map(categories: $0.categories, for: $0) }
//    }
    
    func map(categories: [CategoryEntity], for group: CategoryGroupEntity) -> [CategoryName] {
        let grouped = Dictionary(grouping: categories, by: { $0.name.prefix(1) })
        let sorted = grouped.sorted { $0.key < $1.key }
        
        return sorted.map { letter, categories in
            let mapped = categories.map { category in
                map(category: category)
            }
            return CategoryName(
                id: UUID().uuidString,
                letter: String(letter),
                groupId: group.id,
                groupName: group.name,
                categories: mapped.sorted { $0.name < $1.name } // Sorts payees alphabetically within letter sections
            )
        }
    }
    
//    func map(categories: [Category], for group: CategoryGroup) -> [CategoryName] {
//        Dictionary(grouping: categories, by: { $0.name.prefix(1) })
//            .sorted(by: { $0.key < $1.key })
//            .map { letter, categories in
//                CategoryName(
//                    id: UUID().uuidString,
//                    letter: String(letter),
//                    groupId: group.id,
//                    groupName: group.name,
//                    categories: categories
//                        .map(map(category:))
//                        .sorted(by: { $0.name < $1.name })
//                )
//            }
//    }
    
    func map(category: CategoryEntity) -> TransactionCategoryPresentation {
        return TransactionCategoryPresentation(id: category.id, name: category.name)
    }
}
