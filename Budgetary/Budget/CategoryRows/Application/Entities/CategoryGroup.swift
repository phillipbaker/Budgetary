//
//  CategoryGroup.swift
//  Budgetary
//
//  Created by Phillip Baker on 08/12/2025.
//

import Foundation

public struct CategoryGroup: Equatable, Hashable, Identifiable, Sendable {
    public let id: ID<CategoryGroup>
    let name: String
    let isHidden: Bool
    let categories: [Category]
    
    func replacing(_ category: Category) -> CategoryGroup {
        return CategoryGroup(
            id: self.id,
            name: self.name,
            isHidden: self.isHidden,
            categories: self.categories.map { $0.id == category.id ? category : $0 }
        )
    }
    
    func adding(_ category: Category) -> CategoryGroup {
        return CategoryGroup(
            id: self.id,
            name: self.name,
            isHidden: self.isHidden,
            categories: self.categories + [category]
        )
    }
}
