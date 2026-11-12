//
//  Array+CategoryGroupRow.swift
//  Budgetary
//
//  Created by Phillip Baker on 05/11/2026.
//

extension [CategoryGroupRow] {
    var readyToAssignCategoryID: ID<CategoryRow>? {
        first { $0.kind == .inflow }?.categories.first?.id
    }
}
