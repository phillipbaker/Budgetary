//
//  NewCategoryUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

import Factory
import Foundation

final class NewCategoryUseCase {
    var source: NewCategorySource = Container.shared.newCategorySource()
    var mapper: BudgetMapper = Container.shared.budgetMapper()
    
    func addCategory(with name: String, toGroupWithId id: String) async {
        let newCategory = CategoryPlain(
            id: UUID().uuidString,
            name: name,
            notes: "",
            isHidden: false,
            assigned: [:]
        )
        
        guard let group = await source.findCategoryGroup(by: id) else { return }
        
        let updatedCategories = group.categories + [newCategory]
        let updatedGroup = CategoryGroupPlain(id: group.id, name: group.name, isHidden: group.isHidden, categories: updatedCategories)
        await source.update(categoryGroup: updatedGroup)
    }
}
