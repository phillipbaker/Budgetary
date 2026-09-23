//
//  CategoryGroupPlain.swift
//  Budgetary
//
//  Created by Phillip Baker on 03/11/2024.
//

import Foundation

public struct CategoryGroupPlain: Equatable, Sendable {
    let id: ID<CategoryGroupPlain>
    let name: String
    let isHidden: Bool
    let categories: [CategoryPlain]
}
