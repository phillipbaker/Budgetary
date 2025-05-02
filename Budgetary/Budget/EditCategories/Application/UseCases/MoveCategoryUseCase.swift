//
//  ReorderCategoriesUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

import Factory
//import Foundation

final class MoveCategoryUseCase {
    let source: MoveCategorySource = Container.shared.moveCategorySource()
    let mapper: BudgetMapper = Container.shared.budgetMapper()
    
    func move(categoryId: String, to destinationGroupId: String, at index: Int) async {
        guard let sourceGroup = await source.findCategoryGroup(containing: categoryId) else { return }
        guard let category = sourceGroup.categories.first(where: { $0.id == categoryId }) else { return }
        
        if sourceGroup.id == destinationGroupId {
            let head = sourceGroup.categories.prefix(index)
            let tail = sourceGroup.categories.dropFirst(index)
            
            
            let updatedSourceGroup = CategoryGroupPlain(
                id: sourceGroup.id,
                name: sourceGroup.name,
                isHidden: sourceGroup.isHidden,
                categories: head + [category] + tail
            )
            
            await source.update(categoryGroup: updatedSourceGroup)
        } else {
            let updatedSourceGroup = CategoryGroupPlain(
                id: sourceGroup.id,
                name: sourceGroup.name,
                isHidden: sourceGroup.isHidden,
                categories: sourceGroup.categories.filter { $0.id != categoryId }
            )
            
            guard let destinationGroup = await source.findCategoryGroup(by: destinationGroupId) else { return }
            
            let head = destinationGroup.categories.prefix(index)
            let tail = destinationGroup.categories.dropFirst(index)
            
            let updatedDestinationGroup = CategoryGroupPlain(
                id: destinationGroup.id,
                name: destinationGroup.name,
                isHidden: destinationGroup.isHidden,
                categories: head + [category] + tail
            )
            
            await source.update(categoryGroup: updatedSourceGroup)
            await source.update(categoryGroup: updatedDestinationGroup)
        }
    }
}
