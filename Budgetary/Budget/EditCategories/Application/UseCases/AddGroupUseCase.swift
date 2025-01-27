//
//  AddGroupUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

import Dependencies
import Foundation

public class AddGroupUseCase {
    var source: AddGroupSource
    var mapper: BudgetMapper
    
    public init(source: AddGroupSource, mapper: BudgetMapper) {
        self.source = source
        self.mapper = mapper
    }
    
    func addGroup() -> CategoryGroup {
        let newGroup = CategoryGroup(
            id: UUID().uuidString,
            name: "",
            isHidden: false,
            assignedTotal: [:],
            activityTotal: [:],
            availableTotal: [:],
            categories: []
        )
        source.add(newGroup)
        return newGroup
    }
}
