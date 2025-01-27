//
//  RemoveGroupUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

import Dependencies

public class RemoveGroupUseCase {
    var source: RemoveGroupSource
    var mapper: BudgetMapper
    
    public init(source: RemoveGroupSource, mapper: BudgetMapper) {
        self.source = source
        self.mapper = mapper
    }
    
    // Just get ID and pass that through to delete?
    func removeGroup(id: String) {
        let group = source.findCategoryGroup(by: id)
        source.remove(group)
    }
}
