//
//  String+normalizedForComparison.swift
//  Budgetary
//
//  Created by Phillip Baker on 18/03/2026.
//

import Foundation

extension String {
    func normalizedForComparison() -> String {
        return self
            .lowercased() // remove if you want case-sensitive
            .components(separatedBy: CharacterSet.punctuationCharacters)
            .joined()
    }
}
