//
//  CategoryGroupDb.swift
//  Budgetary
//
//  Created by Phillip Baker on 03/11/2024.
//

import Foundation
import SwiftData

@Model
final class CategoryGroupDb: Equatable {
    #Unique<CategoryGroupDb>([\.id, \.name])
    
    var id: String
    var name: String
    var isHidden: Bool
    @Relationship(deleteRule: .cascade) var categories: [CategoryDb]
    
    init(
        id: String = UUID().uuidString,
        name: String,
        isHidden: Bool = false,
        categories: [CategoryDb] = []
    ) {
        self.id = id
        self.name = name
        self.isHidden = isHidden
        self.categories = categories
    }
}
