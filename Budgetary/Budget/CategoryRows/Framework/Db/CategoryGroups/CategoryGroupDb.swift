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
    var kindRawValue: String = CategoryGroupKindDb.regular.rawValue
    var isHidden: Bool
    @Relationship(deleteRule: .cascade) var categories: [CategoryDb]
    
    var kind: CategoryGroupKindDb {
        get { CategoryGroupKindDb(rawValue: kindRawValue) ?? .regular }
        set { kindRawValue = newValue.rawValue }
    }

    init(
        externalID: UUID,
        name: String,
        kind: CategoryGroupKindDb,
        isHidden: Bool,
        categories: [CategoryDb]
    ) {
        self.externalID = externalID
        self.name = name
        self.kindRawValue = kind.rawValue
        self.isHidden = isHidden
        self.categories = categories
    }
}
