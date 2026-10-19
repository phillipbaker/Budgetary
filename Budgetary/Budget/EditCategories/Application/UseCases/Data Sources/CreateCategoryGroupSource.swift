//
//  CreateCategoryGroupSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

public protocol CreateCategoryGroupSource: Sendable {
    func create(categoryGroup: CategoryGroupPlain) async
}
