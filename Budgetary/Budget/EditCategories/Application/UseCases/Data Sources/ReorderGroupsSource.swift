//
//  ReorderGroupsSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

import Foundation

public protocol ReorderGroupsSource {
    func moveGroups(from offsets: IndexSet, to destination: Int)
}

class ReorderGroupsSourceImpl: ReorderGroupsSource {
    func moveGroups(from offsets: IndexSet, to destination: Int) {}
}
