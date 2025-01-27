//
//  RenameCategorySource.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

import Foundation

public protocol RenameCategorySource {
    func findCategory(by id: String) -> Category
    func rename(_ category: Category, to name: String)
}

class RenameCategorySourceImpl: RenameCategorySource {
    func findCategory(by id: String) -> Category {
        .amazonPrime
    }
    func rename(_ category: Category, to name: String) {}
}
