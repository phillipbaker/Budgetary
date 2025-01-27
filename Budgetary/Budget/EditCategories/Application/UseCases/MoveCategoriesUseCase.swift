//
//  MoveCategoriesUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

import Dependencies

public class MoveCategoriesUseCase {
    var source: MoveCategoriesSource
    
    public init(source: MoveCategoriesSource) {
        self.source = source
    }
    
    func move(
        categories: [Category],
        form sourceGroup: CategoryGroup,
        to destination: CategoryGroup,
        at index: Int
    ) {
        source.move(categories, from: sourceGroup, to: destination, at: index)
    }
}
