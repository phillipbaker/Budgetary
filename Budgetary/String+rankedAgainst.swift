//
//  String+rankedAgainst.swift
//  Budgetary
//
//  Created by Phillip Baker on 12/06/2025.
//

extension String {
    func rankedAgainst(text: String) -> Int {
        let lowerSelf = self.lowercased()
        let lowerText = text.lowercased()
        
        if lowerSelf == lowerText {
            return 0  // Best match
        } else if lowerSelf.hasPrefix(lowerText) {
            return 1  // Starts with query
        } else if lowerSelf.contains(lowerText) {
            return 2  // Contains query
        } else {
            return 3  // No match
        }
    }
}
