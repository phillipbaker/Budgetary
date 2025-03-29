//
//  RenameGroupUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

public class RenameGroupUseCase {
    var source: RenameGroupSource
    var mapper: BudgetMapper
    
    public init(source: RenameGroupSource, mapper: BudgetMapper) {
        self.source = source
        self.mapper = mapper
    }
    
    func rename(_ group: CategoryGroupPresentation, to name: String) {
        let group = source.findGroup(by: group.id)
        source.rename(group, to: name)
    }
}
