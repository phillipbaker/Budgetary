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
    @Attribute(.unique) var externalID: UUID
    var name: String
    var isHidden: Bool
    @Relationship(deleteRule: .cascade) var categories: [CategoryDb]
    
    init(
        externalID: UUID,
        name: String,
        isHidden: Bool,
        categories: [CategoryDb]
    ) {
        self.externalID = externalID
        self.name = name
        self.isHidden = isHidden
        self.categories = categories
    }
}
