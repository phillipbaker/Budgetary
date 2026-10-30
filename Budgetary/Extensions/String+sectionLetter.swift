//
//  String+sectionLetter.swift
//  Budgetary
//
//  Created by Phillip Baker on 29/10/2026.
//

import Foundation

extension String {
    var sectionLetter: String {
        guard let first = self.trimmingCharacters(in: .whitespaces).first,
              first.isLetter
        else { return "#" }
        
        return String(first)
            .folding(options: .diacriticInsensitive, locale: .current)
            .uppercased()
    }
}
