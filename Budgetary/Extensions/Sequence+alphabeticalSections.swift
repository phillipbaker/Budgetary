//
//  Sequence+alphabeticalSections.swift
//  Budgetary
//
//  Created by Phillip Baker on 30/10/2026.
//

import Foundation

extension Sequence {
    /// Groups elements into sections by the first letter of their name, with "#" first,
    /// then A–Z. Elements within each section are sorted by name.
    func alphabeticalSections(by name: KeyPath<Element, String>) -> [(letter: String, elements: [Element])] {
        Dictionary(grouping: self) { $0[keyPath: name].sectionLetter }
            .sorted { lhs, rhs in
                switch (lhs.key, rhs.key) {
                case ("#", _): true
                case (_, "#"): false
                default: lhs.key < rhs.key
                }
            }
            .map { letter, elements in
                (letter, elements.sorted {
                    $0[keyPath: name].localizedStandardCompare($1[keyPath: name]) == .orderedAscending
                })
            }
    }
}
