//
//  CalculatorStateTests.swift
//  BudgetaryTests
//
//  Created on 04/03/2026.
//

import Foundation
import Testing
@testable import Budgetary

// MARK: - Helpers

private func idle(_ value: Decimal = 0) -> CalculatorState {
    .idle(lhs: value)
}

private func pending(
    lhs: Decimal,
    operation: AmountOperation,
    rhs: Decimal = 0
) -> CalculatorState {
    .pendingOperation(lhs: lhs, operation: operation, rhs: rhs)
}

// MARK: - Accessors

@Suite("primary")
struct PrimaryAccessorTests {
    @Test func idle_returnsLhs() {
        #expect(idle(50).primary == 50)
    }

    @Test func idle_zero() {
        #expect(idle(0).primary == 0)
    }

    @Test func pending_returnsLhs() {
        #expect(pending(lhs: 99, operation: .add).primary == 99)
    }

    @Test func pending_lhsIsNotAffectedByRhs() {
        #expect(pending(lhs: 10, operation: .subtract, rhs: 200).primary == 10)
    }
}

@Suite("secondary")
struct SecondaryAccessorTests {
    @Test func idle_returnsNil() {
        #expect(idle(50).secondary == nil)
    }

    @Test func pending_returnsRhs() {
        #expect(pending(lhs: 10, operation: .add, rhs: 30).secondary == 30)
    }

    @Test func pending_rhsZero_returnsZero() {
        #expect(pending(lhs: 10, operation: .add, rhs: 0).secondary == 0)
    }
}

@Suite("operation")
struct OperationAccessorTests {
    @Test func idle_returnsNil() {
        #expect(idle(50).operation == nil)
    }

    @Test func pending_add_returnsAdd() {
        #expect(pending(lhs: 10, operation: .add).operation == .add)
    }

    @Test func pending_subtract_returnsSubtract() {
        #expect(pending(lhs: 10, operation: .subtract).operation == .subtract)
    }
}

// MARK: - Magnitude Invariant

@Suite("Magnitude invariant — primary and secondary are always positive")
struct MagnitudeInvariantTests {

    // settingPrimary

    @Test func settingPrimary_positiveValue_storesAsIs() {
        let state = idle().settingPrimary(42)
        #expect(state.primary == 42)
    }

    @Test func settingPrimary_negativeValue_storesMagnitude() {
        let state = idle().settingPrimary(-42)
        #expect(state.primary == 42)
    }

    @Test func settingPrimary_zero_storesZero() {
        let state = idle().settingPrimary(0)
        #expect(state.primary == 0)
    }

    @Test func settingPrimary_whilePending_negativeValue_storesMagnitude() {
        let state = pending(lhs: 10, operation: .add, rhs: 5).settingPrimary(-99)
        #expect(state.primary == 99)
    }

    // settingSecondary

    @Test func settingSecondary_positiveValue_storesAsIs() {
        let state = pending(lhs: 10, operation: .add).settingSecondary(55)
        #expect(state.secondary == 55)
    }

    @Test func settingSecondary_negativeValue_storesMagnitude() {
        let state = pending(lhs: 10, operation: .add).settingSecondary(-55)
        #expect(state.secondary == 55)
    }

    @Test func settingSecondary_zero_storesZero() {
        let state = pending(lhs: 10, operation: .add).settingSecondary(0)
        #expect(state.secondary == 0)
    }

    // applyingOperation

    @Test func applyingOperation_lhsIsStoredAsMagnitude() {
        // If somehow a negative lhs existed, applyingOperation should clean it
        let state = CalculatorState.idle(lhs: -30).applyingOperation(.add)
        #expect(state.primary == 30)
    }
}

// MARK: - settingPrimary

@Suite("settingPrimary")
struct SettingPrimaryTests {
    @Test func idle_updatesPrimary() {
        let result = idle(10).settingPrimary(99)
        #expect(result == idle(99))
    }

    @Test func idle_overwritesPreviousValue() {
        let result = idle(50).settingPrimary(1)
        #expect(result.primary == 1)
    }

    @Test func pending_updatesLhsPreservesOperationAndRhs() {
        let result = pending(lhs: 10, operation: .add, rhs: 5).settingPrimary(20)
        #expect(result.primary == 20)
        #expect(result.operation == .add)
        #expect(result.secondary == 5)
    }

    @Test func pending_doesNotChangeToIdle() {
        let result = pending(lhs: 10, operation: .subtract, rhs: 3).settingPrimary(99)
        if case .pendingOperation = result { } else {
            Issue.record("Expected .pendingOperation after settingPrimary on pending state")
        }
    }
}

// MARK: - settingSecondary

@Suite("settingSecondary")
struct SettingSecondaryTests {
    @Test func pending_updatesRhs() {
        let result = pending(lhs: 10, operation: .add, rhs: 0).settingSecondary(30)
        #expect(result.secondary == 30)
    }

    @Test func pending_preservesLhsAndOperation() {
        let result = pending(lhs: 10, operation: .subtract, rhs: 0).settingSecondary(7)
        #expect(result.primary == 10)
        #expect(result.operation == .subtract)
    }

    @Test func idle_isNoOp() {
        let original = idle(50)
        let result = original.settingSecondary(99)
        #expect(result == original)
    }

    @Test func idle_secondaryRemainsNil() {
        let result = idle(50).settingSecondary(99)
        #expect(result.secondary == nil)
    }
}

// MARK: - applyingOperation

@Suite("applyingOperation")
struct ApplyingOperationTests {
    @Test func idle_transitionsToPending() {
        let result = idle(50).applyingOperation(.add)
        if case .pendingOperation = result { } else {
            Issue.record("Expected .pendingOperation")
        }
    }

    @Test func idle_preservesLhsAsNewPrimary() {
        let result = idle(50).applyingOperation(.add)
        #expect(result.primary == 50)
    }

    @Test func idle_setsOperation() {
        #expect(idle(10).applyingOperation(.add).operation == .add)
        #expect(idle(10).applyingOperation(.subtract).operation == .subtract)
    }

    @Test func idle_rhsInitialisedToZero() {
        let result = idle(10).applyingOperation(.add)
        #expect(result.secondary == 0)
    }

    @Test func pending_isNoOp() {
        // Chaining is handled by the ViewModel — CalculatorState itself does not chain
        let original = pending(lhs: 10, operation: .add, rhs: 5)
        let result = original.applyingOperation(.subtract)
        #expect(result == original)
    }

    @Test func idle_zero_lhsIsZero() {
        let result = idle(0).applyingOperation(.add)
        #expect(result.primary == 0)
    }
}

// MARK: - cancelledOperation

@Suite("cancelledOperation")
struct CancelledOperationTests {
    @Test func pending_returnsIdleWithOriginalLhs() {
        let result = pending(lhs: 50, operation: .add, rhs: 30).cancelledOperation()
        #expect(result == idle(50))
    }

    @Test func pending_discardsRhsAndOperation() {
        let result = pending(lhs: 50, operation: .subtract, rhs: 99).cancelledOperation()
        #expect(result.operation == nil)
        #expect(result.secondary == nil)
    }

    @Test func idle_isNoOp() {
        let original = idle(50)
        #expect(original.cancelledOperation() == original)
    }

    @Test func pending_withZeroLhs_returnsIdleZero() {
        let result = pending(lhs: 0, operation: .add, rhs: 20).cancelledOperation()
        #expect(result == idle(0))
    }
}

// MARK: - State identity and Equatable

@Suite("Equatable")
struct EquatableTests {
    @Test func idle_equalWhenSameLhs() {
        #expect(idle(10) == idle(10))
    }

    @Test func idle_notEqualWhenDifferentLhs() {
        #expect(idle(10) != idle(20))
    }

    @Test func pending_equalWhenAllFieldsMatch() {
        #expect(
            pending(lhs: 10, operation: .add, rhs: 5) ==
            pending(lhs: 10, operation: .add, rhs: 5)
        )
    }

    @Test func pending_notEqualWhenOperationDiffers() {
        #expect(
            pending(lhs: 10, operation: .add, rhs: 5) !=
            pending(lhs: 10, operation: .subtract, rhs: 5)
        )
    }

    @Test func pending_notEqualWhenRhsDiffers() {
        #expect(
            pending(lhs: 10, operation: .add, rhs: 5) !=
            pending(lhs: 10, operation: .add, rhs: 6)
        )
    }

    @Test func idle_notEqualToPending() {
        #expect(idle(10) != pending(lhs: 10, operation: .add, rhs: 0))
    }
}

// MARK: - Transition sequences

@Suite("Transition sequences")
struct TransitionSequenceTests {

    // Simulates: user types 50, taps +, types 30
    @Test func typePrimary_tapOperation_typeSecondary() {
        let state = idle()
            .settingPrimary(50)
            .applyingOperation(.add)
            .settingSecondary(30)

        #expect(state.primary == 50)
        #expect(state.operation == .add)
        #expect(state.secondary == 30)
    }

    // Simulates: user types 50, taps +, types 30, deletes back to operation
    @Test func typePrimary_tapOperation_typeSecondary_thenCancel() {
        let state = idle()
            .settingPrimary(50)
            .applyingOperation(.add)
            .settingSecondary(30)
            .cancelledOperation()

        #expect(state == idle(50))
    }

    // Simulates partial secondary entry: 1, then 10, then 100
    @Test func secondaryBuildsIncrementally() {
        let afterOne    = pending(lhs: 50, operation: .add).settingSecondary(1)
        let afterTen    = afterOne.settingSecondary(10)
        let afterHundred = afterTen.settingSecondary(100)

        #expect(afterOne.secondary == 1)
        #expect(afterTen.secondary == 10)
        #expect(afterHundred.secondary == 100)
        // lhs must be unchanged throughout
        #expect(afterHundred.primary == 50)
    }

    // Simulates primary being retyped after operation is open
    @Test func settingPrimaryWhilePending_doesNotResetOperation() {
        let state = idle(10)
            .applyingOperation(.subtract)
            .settingPrimary(20)

        #expect(state.primary == 20)
        #expect(state.operation == .subtract)
        #expect(state.secondary == 0)
    }
}
