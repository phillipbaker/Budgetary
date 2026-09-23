//
//  CategoryGroupRowsState.swift
//  Budgetary
//
//  Created by Phillip Baker on 10/05/2025.
//

public enum CategoryGroupRowsState: Equatable, Hashable, Sendable {
    case notLoaded
    case loading
    case error
    case loaded([CategoryGroupRow])
}
