//
//  CategoryPlain.swift
//  Budgetary
//
//  Created by Phillip Baker on 03/11/2024.
//

import Foundation

public struct CategoryPlain: Equatable, Sendable {
    let id: String
    let name: String
    let notes: String
    let isHidden: Bool
    let assigned: [MonthYear: Decimal]
}
