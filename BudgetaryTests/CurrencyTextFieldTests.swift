//
//  CurrencyTextFieldTests.swift
//  BudgetaryTests
//
//  Created on 05/03/2026.
//

import Testing
import SwiftUI
@testable import Budgetary

@Suite("CurrencyTextField")
struct CurrencyTextFieldTests {

    // MARK: - formattedText

    @Suite("formattedText")
    @MainActor
    struct FormattedTextTests {

        @Test func positiveGBP() {
            #expect(CurrencyTextField.formattedText(value: 1.50, currencyCode: "GBP", primaryIsNegative: false) == "£1.50")
        }

        @Test func negativeGBP() {
            #expect(CurrencyTextField.formattedText(value: 1.50, currencyCode: "GBP", primaryIsNegative: true) == "-£1.50")
        }

        @Test func positiveUSD() {
            #expect(CurrencyTextField.formattedText(value: 10.00, currencyCode: "USD", primaryIsNegative: false) == "US$10.00")
        }

        @Test func negativeUSD() {
            #expect(CurrencyTextField.formattedText(value: 10.00, currencyCode: "USD", primaryIsNegative: true) == "-US$10.00")
        }

        @Test func zero() {
            #expect(CurrencyTextField.formattedText(value: 0, currencyCode: "GBP", primaryIsNegative: false) == "£0.00")
        }

        @Test func negativeZeroHasLeadingMinus() {
            let result = CurrencyTextField.formattedText(value: 0, currencyCode: "GBP", primaryIsNegative: true)
            #expect(result.hasPrefix("-"))
        }

        @Test func largeValue() {
            #expect(CurrencyTextField.formattedText(value: 999_999.99, currencyCode: "GBP", primaryIsNegative: false) == "£999,999.99")
        }

        @Test func penceOnly() {
            #expect(CurrencyTextField.formattedText(value: 0.01, currencyCode: "GBP", primaryIsNegative: false) == "£0.01")
        }
    }

    // MARK: - Coordinator: insert

    @Suite("Coordinator insert")
    @MainActor
    struct InsertTests {

        private func makeCoordinator(onTextChanged: ((Decimal) -> Void)? = nil) -> (CurrencyTextField.Coordinator, () -> Decimal) {
            var value: Decimal = 0
            let coordinator = CurrencyTextField.Coordinator(
                value: Binding(get: { value }, set: { value = $0 }),
                onSubmit: {},
                onTextChanged: onTextChanged
            )
            return (coordinator, { value })
        }

        @Test func singleDigitSetsValueCorrectly() {
            let (coordinator, value) = makeCoordinator()
            coordinator.insert("5")
            #expect(value() == 0.05)
        }

        @Test func multipleDigitsBuildsCorrectValue() {
            let (coordinator, value) = makeCoordinator()
            coordinator.insert("1")
            coordinator.insert("5")
            coordinator.insert("0")
            #expect(value() == 1.50)
        }

        @Test func replacesLeadingZeroInBuffer() {
            let (coordinator, value) = makeCoordinator()
            coordinator.insert("7")
            #expect(value() == Decimal(7) / 100)
            #expect(coordinator.digitBuffer == "7")
        }

        @Test func appendsWhenBufferIsNonZero() {
            let (coordinator, _) = makeCoordinator()
            coordinator.digitBuffer = "1"
            coordinator.insert("2")
            #expect(coordinator.digitBuffer == "12")
        }

        @Test func filtersNonNumericCharacters() {
            let (coordinator, value) = makeCoordinator()
            coordinator.insert("abc5xyz")
            #expect(value() == 0.05)
            #expect(coordinator.digitBuffer == "5")
        }

        @Test func purelyNonNumericInputIsIgnored() {
            let (coordinator, value) = makeCoordinator()
            coordinator.insert("abc")
            #expect(value() == 0)
            #expect(coordinator.digitBuffer == "0")
        }

        @Test func decimalPointIsIgnored() {
            let (coordinator, value) = makeCoordinator()
            coordinator.insert(".")
            #expect(value() == 0)
        }

        @Test func firesOnTextChanged() {
            var reportedValue: Decimal?
            let (coordinator, _) = makeCoordinator(onTextChanged: { reportedValue = $0 })
            coordinator.insert("5")
            #expect(reportedValue == 0.05)
        }

        @Test func largeAmount() {
            let (coordinator, value) = makeCoordinator()
            for digit in ["1", "0", "0", "0", "0", "0"] {
                coordinator.insert(digit)
            }
            #expect(value() == 1000.00)
        }
    }

    // MARK: - Coordinator: deleteKeyTapped

    @Suite("Coordinator deleteKeyTapped")
    @MainActor
    struct DeleteTests {

        private func makeCoordinator(
            onTextChanged: ((Decimal) -> Void)? = nil,
            onDeleteWhileEmpty: (() -> Void)? = nil
        ) -> (CurrencyTextField.Coordinator, () -> Decimal) {
            var value: Decimal = 0
            let coordinator = CurrencyTextField.Coordinator(
                value: Binding(get: { value }, set: { value = $0 }),
                onSubmit: {},
                onTextChanged: onTextChanged,
                onDeleteWhileEmpty: onDeleteWhileEmpty
            )
            return (coordinator, { value })
        }

        @Test func removesLastDigit() {
            let (coordinator, value) = makeCoordinator()
            coordinator.digitBuffer = "150"
            coordinator.deleteKeyTapped()
            #expect(coordinator.digitBuffer == "15")
            #expect(value() == 0.15)
        }

        @Test func singleDigitResetsBufferToZero() {
            let (coordinator, value) = makeCoordinator()
            coordinator.digitBuffer = "5"
            coordinator.deleteKeyTapped()
            #expect(coordinator.digitBuffer == "0")
            #expect(value() == 0)
        }

        @Test func callsOnDeleteWhileEmptyWhenBufferIsZero() {
            var called = false
            let (coordinator, _) = makeCoordinator(onDeleteWhileEmpty: { called = true })
            coordinator.deleteKeyTapped()
            #expect(called)
        }

        @Test func doesNotMutateValueWhenBufferIsZero() {
            let (coordinator, value) = makeCoordinator()
            coordinator.deleteKeyTapped()
            #expect(value() == 0)
        }

        @Test func firesOnTextChanged() {
            var reportedValue: Decimal?
            let (coordinator, _) = makeCoordinator(onTextChanged: { reportedValue = $0 })
            coordinator.digitBuffer = "150"
            coordinator.deleteKeyTapped()
            #expect(reportedValue == 0.15)
        }

        @Test func doesNotFireOnDeleteWhileEmptyWhenBufferIsNonZero() {
            var called = false
            let (coordinator, _) = makeCoordinator(onDeleteWhileEmpty: { called = true })
            coordinator.digitBuffer = "5"
            coordinator.deleteKeyTapped()
            #expect(!called)
        }
    }

    // MARK: - Coordinator: submit

    @Suite("Coordinator submit")
    @MainActor
    struct SubmitTests {

        @Test func callsOnSubmitViaDelegate() {
            var value: Decimal = 0
            var submitted = false
            let coordinator = CurrencyTextField.Coordinator(
                value: Binding(get: { value }, set: { value = $0 }),
                onSubmit: { submitted = true },
                onTextChanged: nil
            )
            _ = coordinator.textFieldShouldReturn(UITextField())
            #expect(submitted)
        }
    }

    // MARK: - Round-trip

    @Suite("Round-trip")
    @MainActor
    struct RoundTripTests {

        private func makeCoordinator() -> (CurrencyTextField.Coordinator, () -> Decimal) {
            var value: Decimal = 0
            let coordinator = CurrencyTextField.Coordinator(
                value: Binding(get: { value }, set: { value = $0 }),
                onSubmit: {},
                onTextChanged: nil
            )
            return (coordinator, { value })
        }

        @Test func insertThenDeleteReturnsToZero() {
            let (coordinator, value) = makeCoordinator()
            coordinator.insert("1")
            coordinator.insert("5")
            coordinator.insert("0")
            #expect(value() == 1.50)

            coordinator.deleteKeyTapped()
            coordinator.deleteKeyTapped()
            coordinator.deleteKeyTapped()
            #expect(value() == 0)
        }

        @Test func acceptsNewInputAfterFullDelete() {
            let (coordinator, value) = makeCoordinator()
            coordinator.insert("5")
            coordinator.deleteKeyTapped()
            coordinator.insert("9")
            #expect(value() == 0.09)
            #expect(coordinator.digitBuffer == "9")
        }
    }
}
