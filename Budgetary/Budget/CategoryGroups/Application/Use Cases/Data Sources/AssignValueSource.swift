//
//  AssignValueSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 14/02/2025.
//

public protocol AssignMoneySource {
    func findCategory(by id: String) async -> CategoryPlain?
    func update(category: CategoryPlain) async
}
