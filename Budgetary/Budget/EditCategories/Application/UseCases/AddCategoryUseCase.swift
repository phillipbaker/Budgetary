//
//  AddCategoryUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

import Foundation

public class AddCategoryUseCase {
    var source: AddCategorySource
    var mapper: BudgetMapper
    
    public init(source: AddCategorySource, mapper: BudgetMapper) {
        self.source = source
        self.mapper = mapper
    }
    
    func addCategory(toGroupWithId id: String) -> Category {
        let newCategory = Category(
            id: UUID().uuidString,
            name: "",
            notes: "",
            isHidden: false,
            assigned: [:],
            activity: [:],
            available: [:]
        )
        
        let group = source.findCategoryGroup(by: id)
        source.add(newCategory, to: group)
        return newCategory
    }
}
