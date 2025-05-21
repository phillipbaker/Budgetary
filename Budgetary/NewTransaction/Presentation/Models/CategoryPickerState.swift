//
//  CategoryPickerState.swift
//  Budgetary
//
//  Created by Phillip Baker on 10/05/2025.
//

public enum CategoryPickerState: Sendable {
    case loading
    case error
    case success([CategoryName])
}
