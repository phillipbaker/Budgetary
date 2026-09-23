//
//  CategoryDb.swift
//  Budgetary
//
//  Created by Phillip Baker on 03/11/2024.
//

import Foundation
import SwiftData

@Model
final class CategoryDb: Equatable {
    @Attribute(.unique) var externalID: UUID
    @Attribute(.unique) var name: String
    var notes: String
    var isHidden: Bool
    var assigned: [MonthYear: Decimal]
    
    init(
        externalID: UUID,
        name: String,
        notes: String,
        isHidden: Bool,
        assigned: [MonthYear : Decimal]
    ) {
        self.externalID = externalID
        self.name = name
        self.notes = notes
        self.isHidden = isHidden
        self.assigned = assigned
    }
}
