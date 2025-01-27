//
//  MoveCategoriesSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 01/11/2024.
//

import Foundation

public protocol MoveCategoriesSource {
    func move(
        _ categories: [Category],
        from sourceGroup: CategoryGroup,
        to destination: CategoryGroup,
        at index: Int
    )
}

class MoveCategoriesSourceImpl: MoveCategoriesSource {
    func move(
        _ categories: [Category],
        from sourceGroup: CategoryGroup,
        to destination: CategoryGroup,
        at index: Int
    ) {

    }
}
