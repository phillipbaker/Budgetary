//
//  ReorderGroupsUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

import Factory
import Foundation

final class MoveCategoryGroupUseCase {
    let source: MoveCategoryGroupSource = Container.shared.moveCategoryGroupSource()
    let mapper: BudgetMapper = Container.shared.budgetMapper()

    func moveCategoryGroup(from sourceIndex: IndexSet, to destinationIndex: Int) async {
        guard let groups = await source.allCategoryGroups() else {
            // throw error
            return
        }
        
        let updatedCategoryGroups: [CategoryGroupPlain] = {
            guard /*sourceIndex != destinationIndex,*/
                  groups.indices.contains(sourceIndex),
                  groups.indices.contains(destinationIndex) else {
                //throw error?
                return groups
            }
            
            guard let sourceIndex = sourceIndex.first else { return groups }
            let element = groups[sourceIndex]
            
            return groups
                .enumerated()
                .filter { $0.offset != sourceIndex }
                .enumerated()
                .map { index, pair in
                    if index == destinationIndex {
                        return [element, pair.element]
                    } else {
                        return [pair.element]
                    }
                }
                .flatMap { $0 }
        }()

        await source.update(categoryGroups: updatedCategoryGroups)
    }
}
