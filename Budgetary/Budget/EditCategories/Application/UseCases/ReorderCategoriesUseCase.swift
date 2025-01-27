//
//  ReorderCategoriesUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

import Dependencies
import Foundation

public class ReorderCategoriesUseCase {
    var source: ReorderCategoriesSource
    var mapper: BudgetMapper
    
    public init(source: ReorderCategoriesSource, mapper: BudgetMapper) {
        self.source = source
        self.mapper = mapper
    }
    
    // TODO: Relying on IndexSet here, is that allowed at this level? Does it count as language support? It’s pretty stable...
    func moveCategories(in group: CategoryGroupPresentation, from offsets: IndexSet, to destination: Int) {
        let group = source.findCategoryGroup(by: group.id)
        source.moveCategories(in: group, from: offsets, to: destination)
    }
}
