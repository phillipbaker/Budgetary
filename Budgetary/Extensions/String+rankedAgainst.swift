//
//  String+rankedAgainst.swift
//  Budgetary
//
//  Created by Phillip Baker on 12/06/2025.
//

extension String {
    func rankedAgainst(text: String) -> Int {
        let normalizedSelf = self.normalizedForComparison
        let normalizedText = text.normalizedForComparison
        
        if normalizedSelf == normalizedText {
            return 0  // Best match
        } else if normalizedSelf.hasPrefix(normalizedText) {
            return 1  // Starts with query
        } else if normalizedSelf.contains(normalizedText) {
            return 2  // Contains query
        } else {
            return 3  // No match
        }
    }
}
