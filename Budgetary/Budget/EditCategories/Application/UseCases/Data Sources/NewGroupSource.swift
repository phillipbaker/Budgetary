//
//  NewGroupSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

public protocol NewGroupSource {
    func addNew(categoryGroup: CategoryGroupPlain) async
}
