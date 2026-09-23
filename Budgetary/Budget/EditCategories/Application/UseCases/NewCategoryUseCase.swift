//
//  NewCategoryUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

import Factory
import Foundation

final class NewCategoryUseCase: Sendable {
    let source: NewCategorySource = Container.shared.newCategorySource()
    let mapper: BudgetMapper = Container.shared.budgetMapper()
    
    func execute(for name: String, andGroupID id: ID<CategoryGroup>) async {
        let newCategory = Category(
            id: .init(),
            name: name,
            notes: "",
            isHidden: false,
            assigned: [:]
        )
        print("NewCategoryUseCase - new category created for: ", newCategory.name)
        
        // TODO: Handle errors here not just return or that in Effect?
        guard let categoryGroupPlain = await source.findCategoryGroup(by: ID<CategoryGroupPlain>(id)) else {
            print("NewCategoryUseCase - no category group found")
            return
        }
        
        let categoryGroup = mapper.map(categoryGroupPlain: categoryGroupPlain)
        print("NewCategoryUseCase - updated group count before: ", categoryGroup.categories.count)
        let updatedGroup = categoryGroup.adding(newCategory)
        
        await source.update(categoryGroup: mapper.map(categoryGroup: updatedGroup))
    }
}
