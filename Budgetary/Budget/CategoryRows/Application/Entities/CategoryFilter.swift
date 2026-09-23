//
//  CategoryFilter.swift
//  Budgetary
//
//  Created by Phillip Baker on 02/10/2024.
//

import Foundation

public enum CategoryFilter: String, Equatable, Identifiable, Sendable {
    case allCategories = "All Categories"
    case underfunded = "Underfunded"
    case moneyAvailable = "Money Available"
    //    case custom
    //    case snoozed
    //    case overfunded
    
    public var id: String { self.rawValue }
}
