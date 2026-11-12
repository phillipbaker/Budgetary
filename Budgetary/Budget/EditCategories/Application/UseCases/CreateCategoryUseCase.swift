//
//  CreateCategoryUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

import Factory
import Foundation

final class CreateCategoryUseCase: Sendable {
    let source: CreateCategorySource = Container.shared.createCategorySource()
    let mapper: BudgetMapper = Container.shared.budgetMapper()
    
    func execute(for name: String, andGroupID id: ID<CategoryGroup>) async {
        let newCategory = Category(
            id: .init(),
            name: name,
            notes: "",
            isHidden: false,
            assigned: [:]
        )
        
        guard let categoryGroupPlain = await source.findCategoryGroup(by: ID<CategoryGroupPlain>(id)) else {
            // TODO: throw error
            return
        }
        
        let categoryGroup = mapper.map(categoryGroupPlain: categoryGroupPlain)
        
        guard categoryGroup.kind != .inflow else {
            // TODO: throw error
            return
        }
 
        let updatedGroup = categoryGroup.adding(newCategory)
        
        await source.update(categoryGroup: mapper.map(categoryGroup: updatedGroup))
    }
}
