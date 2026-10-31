//
//  AlphabeticalSectionsTests.swift
//  Budgetary
//
//  Created by Phillip Baker on 30/10/2026.
//

import Testing
@testable import Budgetary

private func letters<Element>(_ sections: [(letter: String, elements: [Element])]) -> [String] {
    sections.map(\.letter)
}

@Suite("AlphabeticalSections")
struct AlphabeticalSectionsTests {

    private struct Item: Equatable {
        let name: String
        let note: String
    }

    @Suite("sectionLetter")
    struct SectionLetter {
        static let letterNames = [
            (name: "apple", letter: "A"),
            (name: "Apple", letter: "A"),
            (name: "  Snowman", letter: "S"),
            (name: "Éclair", letter: "E"),
            (name: "ñandu", letter: "N"),
        ]

        static let hashNames = ["7-Eleven", "£ Savings", "🎁 Gifts", "&Co", "", "   "]

        @Test("Uses the uppercased first letter, ignoring case, accents and leading spaces",
              arguments: SectionLetter.letterNames)
        func usesFirstLetter(name: String, letter: String) {
            #expect(name.sectionLetter == letter)
        }

        @Test("Uses # for names that don’t start with a letter", arguments: SectionLetter.hashNames)
        func usesHashForNonLetters(name: String) {
            #expect(name.sectionLetter == "#")
        }

        @Test func keepsNonLatinLetters() {
            #expect("日本".sectionLetter == "日")
        }
    }

    @Suite("alphabeticalSections(by:)")
    struct Sections {
        @Test func emptySequenceReturnsNoSections() {
            #expect([String]().alphabeticalSections(by: \.self).isEmpty)
        }

        @Test func groupsByFirstLetter() {
            let sections = ["Banana", "Apple", "Blueberry", "Avocado"].alphabeticalSections(by: \.self)
            #expect(letters(sections) == ["A", "B"])
            #expect(sections.map(\.elements) == [["Apple", "Avocado"], ["Banana", "Blueberry"]])
        }

        @Test func sortsSectionsAlphabeticallyRegardlessOfInputOrder() {
            let sections = ["Zoo", "Mango", "Apple"].alphabeticalSections(by: \.self)
            #expect(letters(sections) == ["A", "M", "Z"])
        }

        @Test func putsHashSectionFirst() {
            let sections = ["Zoo", "7-Eleven", "Apple", "£ Savings"].alphabeticalSections(by: \.self)
            #expect(letters(sections) == ["#", "A", "Z"])
        }

        @Test func groupsDifferentCasesTogether() {
            let sections = ["avocado", "Apple", "APRICOT"].alphabeticalSections(by: \.self)
            #expect(letters(sections) == ["A"])
            #expect(sections.first?.elements == ["Apple", "APRICOT", "avocado"])
        }

        @Test func groupsAccentedLettersWithTheirBaseLetter() {
            let sections = ["Eggs", "Éclair"].alphabeticalSections(by: \.self)
            #expect(letters(sections) == ["E"])
            #expect(sections.first?.elements == ["Éclair", "Eggs"])
        }

        @Test func sortsNumbersNaturallyWithinASection() {
            let sections = ["Item 10", "Item 2", "Item 1"].alphabeticalSections(by: \.self)
            #expect(sections.first?.elements == ["Item 1", "Item 2", "Item 10"])
        }

        @Test func sortsNumbersNaturallyWithinTheHashSection() {
            let sections = ["10 Pin", "2 Sisters"].alphabeticalSections(by: \.self)
            #expect(letters(sections) == ["#"])
            #expect(sections.first?.elements == ["2 Sisters", "10 Pin"])
        }

        @Test func keepsDuplicateNames() {
            let sections = ["Snowman", "Snowman"].alphabeticalSections(by: \.self)
            #expect(sections.first?.elements == ["Snowman", "Snowman"])
        }

        @Test func includesEveryElementExactlyOnce() {
            let names = ["Zoo", "apple", "7-Eleven", "Éclair", "Banana", "", "Avocado"]
            let sectioned = names.alphabeticalSections(by: \.self).flatMap(\.elements)
            #expect(sectioned.count == names.count)
            #expect(Set(sectioned) == Set(names))
        }

        @Test func groupsAndSortsByTheGivenKeyPathAndReturnsElements() {
            let snowman = Item(name: "Snowman", note: "Apple")
            let apple = Item(name: "Apple", note: "Zoo")
            let sections = [snowman, apple].alphabeticalSections(by: \.name)
            #expect(letters(sections) == ["A", "S"])
            #expect(sections.map(\.elements) == [[apple], [snowman]])
        }
    }
}
