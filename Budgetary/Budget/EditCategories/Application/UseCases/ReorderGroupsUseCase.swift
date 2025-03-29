//
//  ReorderGroupsUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

import Foundation

public class ReorderGroupsUseCase {
    var source: ReorderGroupsSource
    var mapper: BudgetMapper
    
    public init(source: ReorderGroupsSource, mapper: BudgetMapper) {
        self.source = source
        self.mapper = mapper
    }
    
    func moveGroups(from offsets: IndexSet, to destination: Int) {
        source.moveGroups(from: offsets, to: destination)
    }
}
