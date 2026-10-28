//
//  Sequence+SearchMatching.swift
//  Budgetary
//
//  Created by Phillip Baker on 22/10/2026.
//

extension Sequence {
    func matching(_ query: String, by name: KeyPath<Element, String>) -> [Element] {
        let trimmed = query.trimmingCharacters(in: .whitespaces)
        let candidate = trimmed.normalizedForComparison()
        guard !candidate.isEmpty else { return [] }
        return filter { $0[keyPath: name].normalizedForComparison().contains(candidate) }
            .sorted { $0[keyPath: name].rankedAgainst(text: trimmed) < $1[keyPath: name].rankedAgainst(text: trimmed) }
    }
    
    func first(named query: String, by name: KeyPath<Element, String>) -> Element? {
        let candidate = query.trimmingCharacters(in: .whitespaces).normalizedForComparison()
        return first { $0[keyPath: name].normalizedForComparison() == candidate }
    }

    func contains(_ query: String, by name: KeyPath<Element, String>) -> Bool {
        first(named: query, by: name) != nil
    }
}
