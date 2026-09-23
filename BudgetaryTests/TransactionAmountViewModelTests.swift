//
//  TransactionAmountViewModelTests.swift
//  BudgetaryTests
//
//  Created on 03/03/2026.
//

import Foundation
import Testing
@testable import Budgetary

// MARK: - Helpers

/// Builds a ViewModel in .idle state.
@MainActor private func makeViewModel(
    primary: Decimal = 0,
    userIntendedType: TransactionTypePresentation = .outflow,
    focusIntent: TransactionAmountViewModel.FocusIntent = .none
) -> TransactionAmountViewModel {
    TransactionAmountViewModel(
        calculatorState: .idle(lhs: primary),
        userIntendedType: userIntendedType,
        focusIntent: focusIntent
    )
}

/// Builds a ViewModel in .pendingOperation state.
@MainActor private func makePendingViewModel(
    lhs: Decimal,
    operation: AmountOperation,
    rhs: Decimal,
    userIntendedType: TransactionTypePresentation = .outflow,
    focusIntent: TransactionAmountViewModel.FocusIntent = .secondary
) -> TransactionAmountViewModel {
    TransactionAmountViewModel(
        calculatorState: .pendingOperation(lhs: lhs, operation: operation, rhs: rhs),
        userIntendedType: userIntendedType,
        focusIntent: focusIntent
    )
}

// MARK: - Initialisation

@Suite("Initialisation")
@MainActor
struct InitTests {
    @Test func defaultInit() {
        let vm = TransactionAmountViewModel()
        #expect(vm.focusIntent == .none)
        #expect(vm.transactionType == .outflow)
        #expect(vm.userIntendedType == .outflow)
        #expect(vm.isFirstLaunch == true)
        #expect(vm.datePickerIsPresented == false)
        #expect(vm.transactionTypePickerIsDisabled == false)
        #expect(vm.deleteTransactionConfirmationDialogIsPresented == false)
    }

    @Test func customInit_inflow() {
        let vm = makeViewModel(userIntendedType: .inflow, focusIntent: .primary)
        #expect(vm.transactionType == .inflow)
        #expect(vm.focusIntent == .primary)
    }

    @Test func defaultPrimaryIsZero() {
        let vm = TransactionAmountViewModel()
        #expect(vm.primary == 0)
    }

    @Test func defaultSecondaryIsZero() {
        let vm = TransactionAmountViewModel()
        #expect(vm.secondary == 0)
    }
}

// MARK: - Derived: operationString

@Suite("operationString")
@MainActor
struct OperationStringTests {
    @Test func idle_returnsEmpty() {
        let vm = makeViewModel()
        #expect(vm.operationString == "")
    }

    @Test func pendingAdd_returnsPlus() {
        let vm = makePendingViewModel(lhs: 10, operation: .add, rhs: 0)
        #expect(vm.operationString == "+")
    }

    @Test func pendingSubtract_returnsMinus() {
        let vm = makePendingViewModel(lhs: 10, operation: .subtract, rhs: 0)
        #expect(vm.operationString == "-")
    }
}

// MARK: - Derived: primaryIsNegative

@Suite("primaryIsNegative")
@MainActor
struct PrimaryIsNegativeTests {
    @Test func outflow_isNegative() {
        let vm = makeViewModel(userIntendedType: .outflow)
        #expect(vm.primaryIsNegative == true)
    }

    @Test func inflow_isNotNegative() {
        let vm = makeViewModel(userIntendedType: .inflow)
        #expect(vm.primaryIsNegative == false)
    }

    // Key behaviour: primaryIsNegative reflects userIntendedType (last committed sign),
    // NOT transactionType (live result). So during a pending operation that would flip
    // the type, primaryIsNegative must NOT change until commit.
    @Test func pendingAddOperation_doesNotFlipPrimaryIsNegative_untilCommit() {
        // outflow 5.00 + 10.00 → transactionType flips to .inflow mid-entry
        // but primaryIsNegative must stay false until = is tapped
        let vm = makePendingViewModel(
            lhs: 5,
            operation: .add,
            rhs: 10,
            userIntendedType: .outflow
        )
        #expect(vm.transactionType == .inflow)   // live result has flipped
        #expect(vm.primaryIsNegative == true)    // display must not change yet

        vm.onEquals()

        #expect(vm.primaryIsNegative == false)   // now committed as inflow
        #expect(vm.transactionType == .inflow)
    }
    
    @Test func pendingSubtractOperation_doesNotFlipPrimaryIsNegative_untilCommit() {
        // inflow 5.00 - 10.00 → transactionType flips to .outflow mid-entry
        // but primaryIsNegative must stay true until = is tapped
        let vm = makePendingViewModel(
            lhs: 5,
            operation: .subtract,
            rhs: 10,
            userIntendedType: .inflow
        )
        #expect(vm.transactionType == .outflow)   // live result has flipped
        #expect(vm.primaryIsNegative == false)    // display must not change yet

        vm.onEquals()

        #expect(vm.primaryIsNegative == true)   // now committed as outflow
        #expect(vm.transactionType == .outflow)
    }

    @Test func pendingOperation_outflowStaysNegative_whenPrimaryDominates() {
        // outflow 10.00 - 3.00 → stays outflow throughout
        let vm = makePendingViewModel(
            lhs: 10,
            operation: .subtract,
            rhs: 3,
            userIntendedType: .outflow
        )
        #expect(vm.primaryIsNegative == true)
        vm.onEquals()
        #expect(vm.primaryIsNegative == true)
    }
}

// MARK: - Derived: transactionType

@Suite("transactionType")
@MainActor
struct TransactionTypeTests {
    @Test func idle_honoursUserIntent_outflow() {
        let vm = makeViewModel(userIntendedType: .outflow)
        #expect(vm.transactionType == .outflow)
    }

    @Test func idle_honoursUserIntent_inflow() {
        let vm = makeViewModel(userIntendedType: .inflow)
        #expect(vm.transactionType == .inflow)
    }

    @Test func pending_outflow_add_secondaryExceedsPrimary_flipsToInflow() {
        // -5 + 10 = 5 → inflow
        let vm = makePendingViewModel(lhs: 5, operation: .add, rhs: 10,
                                      userIntendedType: .outflow)
        #expect(vm.transactionType == .inflow)
    }

    @Test func pending_outflow_subtract_secondaryExceedsPrimary_flipsToInflow() {
        // -5 - 10 = -15 → stays outflow (result is negative)
        // Actually: outflow subtract means -5 - 10 = -15, still outflow
        let vm = makePendingViewModel(lhs: 5, operation: .subtract, rhs: 10,
                                      userIntendedType: .outflow)
        // signedPrimary = -5, result = -5 - 10 = -15 → outflow
        #expect(vm.transactionType == .outflow)
    }

    @Test func pending_inflow_subtract_secondaryExceedsPrimary_flipsToOutflow() {
        // 5 - 10 = -5 → outflow
        let vm = makePendingViewModel(lhs: 5, operation: .subtract, rhs: 10,
                                      userIntendedType: .inflow)
        #expect(vm.transactionType == .outflow)
    }

    @Test func pending_resultZero_honoursUserIntent() {
        // 5 - 5 = 0 → honour intent
        let vm = makePendingViewModel(lhs: 5, operation: .subtract, rhs: 5,
                                      userIntendedType: .inflow)
        #expect(vm.transactionType == .inflow)
    }
}

// MARK: - Derived: transactionTypePickerIsDisabled

@Suite("transactionTypePickerIsDisabled")
@MainActor
struct PickerDisabledTests {
    @Test func idle_alwaysEnabled() {
        let vm = makeViewModel(primary: 100, userIntendedType: .outflow)
        #expect(vm.transactionTypePickerIsDisabled == false)
    }

    @Test func pending_primaryDominates_enabled() {
        let vm = makePendingViewModel(lhs: 100, operation: .add, rhs: 30)
        #expect(vm.transactionTypePickerIsDisabled == false)
    }

    @Test func pending_secondaryDominates_disabled() {
        let vm = makePendingViewModel(lhs: 30, operation: .add, rhs: 100)
        #expect(vm.transactionTypePickerIsDisabled == true)
    }

    @Test func pending_equalValues_enabled() {
        let vm = makePendingViewModel(lhs: 50, operation: .add, rhs: 50)
        #expect(vm.transactionTypePickerIsDisabled == false)
    }
}

// MARK: - Derived: result

@Suite("result")
@MainActor
struct ResultTests {
    @Test func idle_outflow_returnsNegativePrimary() {
        let vm = makeViewModel(primary: 100, userIntendedType: .outflow)
        #expect(vm.result == -100)
    }

    @Test func idle_inflow_returnsPositivePrimary() {
        let vm = makeViewModel(primary: 100, userIntendedType: .inflow)
        #expect(vm.result == 100)
    }

    @Test func pending_outflow_add() {
        let vm = makePendingViewModel(lhs: 100, operation: .add, rhs: 30,
                                      userIntendedType: .outflow)
        #expect(vm.result == -70)   // -100 + 30
    }

    @Test func pending_outflow_subtract() {
        let vm = makePendingViewModel(lhs: 100, operation: .subtract, rhs: 30,
                                      userIntendedType: .outflow)
        #expect(vm.result == -130)  // -100 - 30
    }

    @Test func pending_inflow_add() {
        let vm = makePendingViewModel(lhs: 100, operation: .add, rhs: 30,
                                      userIntendedType: .inflow)
        #expect(vm.result == 130)   // 100 + 30
    }

    @Test func pending_inflow_subtract() {
        let vm = makePendingViewModel(lhs: 100, operation: .subtract, rhs: 30,
                                      userIntendedType: .inflow)
        #expect(vm.result == 70)    // 100 - 30
    }
}

// MARK: - updatePrimary / updateSecondary

@Suite("Updating Values")
@MainActor
struct UpdateValuesTests {
    @Test func updatePrimary_storesValue() {
        let vm = makeViewModel()
        vm.updatePrimary(42)
        #expect(vm.primary == 42)
    }

    @Test func updatePrimary_whilePending_preservesOperation() {
        let vm = makePendingViewModel(lhs: 10, operation: .add, rhs: 5)
        vm.updatePrimary(20)
        #expect(vm.primary == 20)
        #expect(vm.calculatorState.operation == .add)
    }

    @Test func updateSecondary_storesValue() {
        let vm = makePendingViewModel(lhs: 10, operation: .add, rhs: 0)
        vm.updateSecondary(99)
        #expect(vm.secondary == 99)
    }

    @Test func updateSecondary_whenIdle_isNoOp() {
        let vm = makeViewModel(primary: 10)
        vm.updateSecondary(50)
        #expect(vm.secondary == 0) // idle has no secondary
    }
}

// MARK: - commit (via onEquals / onSubmit)

@Suite("commit")
@MainActor
struct CommitTests {

    // outflow 100 + 30 → result = -70 → committed primary = 70, type = outflow
    @Test func outflow_add_primaryDominates() {
        let vm = makePendingViewModel(lhs: 100, operation: .add, rhs: 30,
                                      userIntendedType: .outflow)
        vm.onEquals()
        #expect(vm.primary == 70)
        #expect(vm.userIntendedType == .outflow)
        #expect(vm.transactionType == .outflow)
        #expect(vm.calculatorState.operation == nil)
        #expect(vm.secondary == 0)
    }

    // outflow 50 + 120 → result = 70 → committed primary = 70, type = inflow
    @Test func outflow_add_secondaryDominates_switchesToInflow() {
        let vm = makePendingViewModel(lhs: 50, operation: .add, rhs: 120,
                                      userIntendedType: .outflow)
        vm.onEquals()
        #expect(vm.primary == 70)
        #expect(vm.userIntendedType == .inflow)
        #expect(vm.transactionType == .inflow)
    }

    // outflow 100 - 30 → result = -130 → stays outflow, primary = 130
    @Test func outflow_subtract_increasesMagnitude() {
        let vm = makePendingViewModel(lhs: 100, operation: .subtract, rhs: 30,
                                      userIntendedType: .outflow)
        vm.onEquals()
        #expect(vm.primary == 130)
        #expect(vm.userIntendedType == .outflow)
    }

    // inflow 100 + 30 → result = 130 → stays inflow
    @Test func inflow_add_increasesMagnitude() {
        let vm = makePendingViewModel(lhs: 100, operation: .add, rhs: 30,
                                      userIntendedType: .inflow)
        vm.onEquals()
        #expect(vm.primary == 130)
        #expect(vm.userIntendedType == .inflow)
    }

    // inflow 5 - 10 → result = -5 → switches to outflow
    @Test func inflow_subtract_secondaryDominates_switchesToOutflow() {
        let vm = makePendingViewModel(lhs: 5, operation: .subtract, rhs: 10,
                                      userIntendedType: .inflow)
        vm.onEquals()
        #expect(vm.primary == 5)
        #expect(vm.userIntendedType == .outflow)
        #expect(vm.transactionType == .outflow)
    }

    // The bug case: outflow 9.99 + 10.00 → result = 0.01 inflow, not --£0.01
    @Test func outflow_add_nearEqual_givesSmallInflow() {
        let vm = makePendingViewModel(lhs: 9.99, operation: .add, rhs: 10.00,
                                      userIntendedType: .outflow)
        vm.onEquals()
        #expect(vm.primary == 0.01)
        #expect(vm.userIntendedType == .inflow)
        #expect(vm.primaryIsNegative == false)
    }

    @Test func onSubmit_withPendingOperation_commits() {
        let vm = makePendingViewModel(lhs: 100, operation: .add, rhs: 20,
                                      userIntendedType: .outflow)
        vm.onSubmit()
        #expect(vm.primary == 80)
        #expect(vm.calculatorState.operation == nil)
    }

    @Test func onSubmit_withNoOperation_doesNothing() {
        let vm = makeViewModel(primary: 50)
        vm.onSubmit()
        #expect(vm.primary == 50)
        #expect(vm.calculatorState.operation == nil)
    }

    @Test func onEquals_setsFocusToPrimary() {
        let vm = makePendingViewModel(lhs: 10, operation: .add, rhs: 5,
                                      focusIntent: .secondary)
        vm.onEquals()
        #expect(vm.focusIntent == .primary)
    }

    @Test func onSubmit_setsFocusToNone() {
        let vm = makePendingViewModel(lhs: 10, operation: .add, rhs: 5,
                                      focusIntent: .secondary)
        vm.onSubmit()
        #expect(vm.focusIntent == .none)
    }
}

// MARK: - onOperation

@Suite("onOperation")
@MainActor
struct OnOperationTests {
    @Test func idle_setsOperationAndFocus() {
        let vm = makeViewModel(primary: 100, focusIntent: .primary)
        vm.onOperation(.add)
        #expect(vm.calculatorState.operation == .add)
        #expect(vm.focusIntent == .secondary)
    }

    @Test func idle_preservesPrimaryAslhs() {
        let vm = makeViewModel(primary: 50)
        vm.onOperation(.subtract)
        #expect(vm.primary == 50)
    }

    // Chaining: outflow 100 + 30, then tap + → commits to 70, opens new +
    @Test func chaining_commitsFirstOperationBeforeOpeningSecond() {
        let vm = makePendingViewModel(lhs: 100, operation: .add, rhs: 30,
                                      userIntendedType: .outflow)
        vm.onOperation(.subtract)
        #expect(vm.primary == 70)
        #expect(vm.calculatorState.operation == .subtract)
        #expect(vm.userIntendedType == .outflow)
        #expect(vm.focusIntent == .secondary)
    }

    // Chaining type flip: outflow 5 + 10, then tap + → commits to 5 inflow, opens new +
    @Test func chaining_committedTypeFlipsCorrectly() {
        let vm = makePendingViewModel(lhs: 5, operation: .add, rhs: 10,
                                      userIntendedType: .outflow)
        vm.onOperation(.add)
        #expect(vm.primary == 5)
        #expect(vm.userIntendedType == .inflow)
        #expect(vm.calculatorState.operation == .add)
    }

    // Chaining syncs userIntendedType from committed result
    @Test func chaining_syncsuserIntendedType() {
        let vm = makePendingViewModel(lhs: 50, operation: .add, rhs: 120,
                                      userIntendedType: .outflow)
        vm.onOperation(.subtract)
        // -50 + 120 = 70 → inflow committed
        #expect(vm.userIntendedType == .inflow)
    }
}

// MARK: - onDeleteWhileEmpty

@Suite("onDeleteWhileEmpty")
@MainActor
struct DeleteWhileEmptyTests {
    @Test func whenSecondary_returnsFocusToPrimaryAndCancelsOp() {
        let vm = makePendingViewModel(lhs: 50, operation: .add, rhs: 0,
                                      focusIntent: .secondary)
        vm.onDeleteWhileEmpty()
        #expect(vm.focusIntent == .primary)
        #expect(vm.calculatorState.operation == nil)
        #expect(vm.primary == 50) // lhs preserved
    }

    @Test func whenNotSecondary_isNoOp() {
        let vm = makeViewModel(primary: 50, focusIntent: .primary)
        vm.onDeleteWhileEmpty()
        #expect(vm.focusIntent == .primary)
        #expect(vm.primary == 50)
    }
}

// MARK: - setTransactionType

@Suite("setTransactionType")
@MainActor
struct SetTransactionTypeTests {
    @Test func idle_switchesOutflowToInflow() {
        let vm = makeViewModel(userIntendedType: .outflow)
        vm.setTransactionType(to: .inflow)
        #expect(vm.userIntendedType == .inflow)
        #expect(vm.transactionType == .inflow)
        #expect(vm.primaryIsNegative == false)
    }

    @Test func idle_switchesInflowToOutflow() {
        let vm = makeViewModel(userIntendedType: .inflow)
        vm.setTransactionType(to: .outflow)
        #expect(vm.userIntendedType == .outflow)
        #expect(vm.primaryIsNegative == true)
    }

    @Test func noOpWhenSameType() {
        let vm = makeViewModel(userIntendedType: .outflow)
        vm.setTransactionType(to: .outflow)
        #expect(vm.userIntendedType == .outflow)
    }

    @Test func noOpWhenPickerIsDisabled() {
        // secondary dominates → picker disabled
        let vm = makePendingViewModel(lhs: 30, operation: .add, rhs: 100,
                                      userIntendedType: .outflow)
        #expect(vm.transactionTypePickerIsDisabled == true)
        vm.setTransactionType(to: .inflow)
        #expect(vm.userIntendedType == .outflow) // unchanged
    }

    @Test func allowedWhenPrimaryDominates() {
        let vm = makePendingViewModel(lhs: 100, operation: .add, rhs: 30,
                                      userIntendedType: .outflow)
        vm.setTransactionType(to: .inflow)
        #expect(vm.userIntendedType == .inflow)
    }
}

// MARK: - Delete Transaction Dialog

@Suite("Delete Transaction Dialog")
@MainActor
struct DeleteDialogTests {
    @Test func deleteButtonTapped_presentsDialog() {
        let vm = makeViewModel()
        vm.deleteTransactionButtonTapped()
        #expect(vm.deleteTransactionConfirmationDialogIsPresented == true)
    }

    @Test func cancelDelete_dismissesDialog() {
        let vm = makeViewModel()
        vm.deleteTransactionButtonTapped()
        vm.cancelDeleteButtonTapped()
        #expect(vm.deleteTransactionConfirmationDialogIsPresented == false)
    }

    @Test func confirmDelete_dismissesDialog() {
        let vm = makeViewModel()
        vm.deleteTransactionButtonTapped()
        vm.confirmDeleteTransactionButtonTapped()
        #expect(vm.deleteTransactionConfirmationDialogIsPresented == false)
    }
}

// MARK: - Date Picker

@Suite("Date Picker")
@MainActor
struct DatePickerTests {
    @Test func firstTap_presents() {
        let vm = makeViewModel()
        vm.datePickerButtonTapped()
        #expect(vm.datePickerIsPresented == true)
    }

    @Test func secondTap_dismisses() {
        let vm = makeViewModel()
        vm.datePickerButtonTapped()
        vm.datePickerButtonTapped()
        #expect(vm.datePickerIsPresented == false)
    }
}
