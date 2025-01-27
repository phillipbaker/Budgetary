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
    #Unique<CategoryDb>([\.id, \.name])
    
    var id: String
    var name: String
    var notes: String
    var isHidden: Bool
    var assigned: [MonthYear: Decimal]
    
    init(
        id: String = UUID().uuidString,
        name: String,
        notes: String = "",
        isHidden: Bool = false,
        assigned: [MonthYear : Decimal] = [:]
    ) {
        self.id = id
        self.name = name
        self.notes = notes
        self.isHidden = isHidden
        self.assigned = assigned
    }
}
