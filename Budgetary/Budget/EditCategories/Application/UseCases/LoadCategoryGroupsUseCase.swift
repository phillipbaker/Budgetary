//
//  LoadCategoryGroupsUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 02/11/2024.
//

import Dependencies

public class LoadCategoryGroupsUseCase {
    var source: LoadCategoryGroupsSource
    var mapper: BudgetMapper
    
    public init(source: LoadCategoryGroupsSource, mapper: BudgetMapper) {
        self.source = source
        self.mapper = mapper
    }
    
    func load() {}
}
