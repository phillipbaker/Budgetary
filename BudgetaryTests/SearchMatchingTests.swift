//
//  SearchMatchingTests.swift
//  Budgetary
//
//  Created by Phillip Baker on 22/10/2026.
//

import Testing
@testable import Budgetary

@Suite("SearchMatching")
struct SearchMatchingTests {

    static let paddedQueries = [" Snowman", "Snowman ", "  Snowman   "]
    static let caseQueries = ["snowman", "SNOWMAN", "SnowMan"]

    static let punctuationQueries = [
        (query: "yo sushi", name: "Yo! Sushi"),
        (query: "bm", name: "B&M"),
        (query: "sainsburys", name: "Sainsbury’s"),
        (query: "sainsbury's", name: "Sainsbury’s"),
    ]

    static let separatorsAndAccentQueries = [
        (query: "marks spencer", name: "Marks & Spencer"),
        (query: "cafe nero", name: "Café Nero")
    ]

    private struct Item: Equatable {
        let name: String
        let note: String
    }

    @Suite("matching(_:by:)")
    struct Matching {
        @Test func emptySequenceReturnsNothing() {
            #expect([String]().matching("Snowman", by: \.self).isEmpty)
        }

        @Test func whitespaceOnlyReturnsNothing() {
            #expect(["Snowman"].matching("   ", by: \.self).isEmpty)
        }

        @Test(arguments: SearchMatchingTests.paddedQueries)
        func ignoresSurroundingWhitespace(query: String) {
            #expect(["Snowman"].matching(query, by: \.self) == ["Snowman"])
        }

        @Test(arguments: SearchMatchingTests.caseQueries)
        func ignoresCase(query: String) {
            #expect(["Snowman"].matching(query, by: \.self) == ["Snowman"])
        }

        @Test("Ignores punctuation in names", arguments: SearchMatchingTests.punctuationQueries)
        func ignoresPunctuation(query: String, name: String) {
            #expect([name].matching(query, by: \.self) == [name])
        }

        @Test("Treats punctuation between words as a space and ignores accents",
              arguments: SearchMatchingTests.separatorsAndAccentQueries)
        func normalisesSeparatorsAndAccents(query: String, name: String) {
            withKnownIssue("Punctuation is deleted, not replaced with a space; accents aren't folded") {
                #expect([name].matching(query, by: \.self) == [name])
            }
        }

        @Test func matchesOnlyTheGivenKeyPathAndReturnsElements() {
            let snowman = Item(name: "Snowman", note: "Reindeer")
            let reindeer = Item(name: "Reindeer", note: "Snowman")
            #expect([snowman, reindeer].matching("snow", by: \.name) == [snowman])
        }

        @Test func excludesNonMatchingNames() {
            #expect(["Snowman", "Reindeer"].matching("snow", by: \.self) == ["Snowman"])
        }

        @Test func ranksExactThenPrefixThenContains() {
            let names = ["Simon Snowman", "Snowman Sam", "Snowman"]
            #expect(names.matching("Snowman", by: \.self) == ["Snowman", "Snowman Sam", "Simon Snowman"])
        }

        @Test func ranksNormalisedExactMatchFirst() {
            withKnownIssue("rankedAgainst doesn't apply normalizedForComparison") {
                #expect(["BM Electrical", "B&M"].matching("bm", by: \.self) == ["B&M", "BM Electrical"])
            }
        }
    }

    @Suite("first(named:by:)")
    struct FirstNamed {
        @Test func emptySequenceReturnsNothing() {
            #expect([String]().first(named: "Snowman", by: \.self) == nil)
        }

        @Test func whitespaceOnlyReturnsNothing() {
            #expect(["Snowman"].first(named: "   ", by: \.self) == nil)
        }

        @Test(arguments: SearchMatchingTests.paddedQueries)
        func ignoresSurroundingWhitespace(query: String) {
            #expect(["Snowman"].first(named: query, by: \.self) == "Snowman")
        }

        @Test(arguments: SearchMatchingTests.caseQueries)
        func ignoresCase(query: String) {
            #expect(["Snowman"].first(named: query, by: \.self) == "Snowman")
        }

        @Test("Ignores punctuation in names", arguments: SearchMatchingTests.punctuationQueries)
        func ignoresPunctuation(query: String, name: String) {
            #expect([name].first(named: query, by: \.self) == name)
        }

        @Test("Treats punctuation between words as a space and ignores accents",
              arguments: SearchMatchingTests.separatorsAndAccentQueries)
        func normalisesSeparatorsAndAccents(query: String, name: String) {
            withKnownIssue("Punctuation is deleted, not replaced with a space; accents aren't folded") {
                #expect([name].first(named: query, by: \.self) == name)
            }
        }

        @Test func treatsSymbolsAsSignificant() {
            #expect(["Disney+"].first(named: "disney", by: \.self) == nil)
        }

        @Test func doesNotMatchSubstring() {
            #expect(["Snowman"].first(named: "Snow", by: \.self) == nil)
        }

        @Test func matchesOnlyTheGivenKeyPathAndReturnsElements() {
            let snowman = Item(name: "Snowman", note: "Reindeer")
            let reindeer = Item(name: "Reindeer", note: "Snowman")
            #expect([snowman, reindeer].first(named: "reindeer", by: \.note) == snowman)
        }

        @Test func returnsFirstOfSeveralMatches() {
            let names = ["Snowman", "SNOWMAN"]
            #expect(names.first(named: "snowman", by: \.self) == "Snowman")
        }
    }

    @Suite("contains(_:by:)")
    struct Contains {
        @Test func emptySequenceReturnsFalse() {
            #expect(![String]().contains("Snowman", by: \.self))
        }

        @Test func whitespaceOnlyReturnsFalse() {
            #expect(!["Snowman"].contains("   ", by: \.self))
        }

        @Test(arguments: SearchMatchingTests.paddedQueries)
        func ignoresSurroundingWhitespace(query: String) {
            #expect(["Snowman"].contains(query, by: \.self))
        }

        @Test(arguments: SearchMatchingTests.caseQueries)
        func ignoresCase(query: String) {
            #expect(["Snowman"].contains(query, by: \.self))
        }

        @Test("Ignores punctuation in names", arguments: SearchMatchingTests.punctuationQueries)
        func ignoresPunctuation(query: String, name: String) {
            #expect([name].contains(query, by: \.self))
        }

        @Test("Variants that differ only by separators or accents clash",
              arguments: SearchMatchingTests.separatorsAndAccentQueries)
        func separatorAndAccentVariantsClash(query: String, name: String) {
            withKnownIssue("Punctuation is deleted, not replaced with a space; accents aren't folded") {
                #expect([name].contains(query, by: \.self))
            }
        }

        @Test func namesDifferingBySymbolDoNotClash() {
            #expect(!["Disney+"].contains("Disney", by: \.self))
        }

        @Test func doesNotMatchSubstring() {
            #expect(!["Snowman"].contains("Snow", by: \.self))
        }

        @Test func emptyQueryReturnsFalse() {
            #expect(!["Snowman"].contains("", by: \.self))
        }
    }
}
