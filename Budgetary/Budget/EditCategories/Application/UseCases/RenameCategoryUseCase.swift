//
//  RenameCategoryUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

public class RenameCategoryUseCase {
    var source: RenameCategorySource
    var mapper: BudgetMapper
    
    public init(source: RenameCategorySource, mapper: BudgetMapper) {
        self.source = source
        self.mapper = mapper
    }
    
    func rename(_ category: CategoryPresentation, to name: String) {
        let category = source.findCategory(by: category.id)
        source.rename(category, to: name)
    }
}
