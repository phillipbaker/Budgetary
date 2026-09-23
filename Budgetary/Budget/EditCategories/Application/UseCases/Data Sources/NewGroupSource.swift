//
//  NewGroupSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

public protocol NewGroupSource: Sendable {
    func addNew(categoryGroup: CategoryGroupPlain) async
}
