//
//  String+normalizedForComparison.swift
//  Budgetary
//
//  Created by Phillip Baker on 18/03/2026.
//

import Foundation

extension String {
    /// Lowercased, accent-free, and punctuation-insensitive form for search and duplicate checks.
    var normalizedForComparison: String {
        folding(options: [.caseInsensitive, .diacriticInsensitive], locale: nil)
            .replacing(/['’&]/, with: "")
            .replacing(/[\p{P}\s]+/, with: " ")
            .trimmingCharacters(in: .whitespaces)
    }
}
