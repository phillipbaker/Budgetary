//
//  CategoryFilterPresentation.swift
//  Budgetary
//
//  Created by Phillip Baker on 25/11/2024.
//

public enum CategoryFilterPresentation: String, CaseIterable, Equatable, Identifiable, Sendable {
    case allCategories = "All Categories"
    case underfunded = "Underfunded"
    case moneyAvailable = "Money Available"

    public var id: String { self.rawValue }
}
