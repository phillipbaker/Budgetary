//
//  RemoveCategoryUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

public class RemoveCategoryUseCase {
    var source: RemoveCategorySource
    var mapper: BudgetMapper
    
    public init(source: RemoveCategorySource, mapper: BudgetMapper) {
        self.source = source
        self.mapper = mapper
    }
    
    // TODO: Make it support multiple category delete... (variadic paremeter?)
    func removeCategory(id: String, from groupId: String) {
        let group = source.findCategoryGroup(by: groupId)
        source.removeCategory(id: id, from: group)
    }
}
