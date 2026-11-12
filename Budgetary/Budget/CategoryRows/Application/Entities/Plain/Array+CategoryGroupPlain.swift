//
//  Array+CategoryGroupPlain.swift
//  Budgetary
//
//  Created by Phillip Baker on 05/11/2026.
//

extension [CategoryGroupPlain] {
    var readyToAssignCategoryID: ID<CategoryPlain>? {
        first { $0.kind == .inflow }?.categories.first?.id
    }
}
