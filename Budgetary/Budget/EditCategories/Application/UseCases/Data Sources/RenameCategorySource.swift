//
//  RenameCategorySource.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

import Foundation

public protocol RenameCategorySource {
    func findCategory(by id: String) async -> CategoryPlain?
    func update(category: CategoryPlain) async
}
