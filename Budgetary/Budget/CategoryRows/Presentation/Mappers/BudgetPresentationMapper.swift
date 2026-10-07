//
//  BudgetPresentationMapper.swift
//  Budgetary
//
//  Created by Phillip Baker on 24/10/2024.
//

import Foundation
import SwiftUI

public final class BudgetPresentationMapper {
    func mapViewState(from budgetData: BudgetData, for monthYear: MonthYear, and filter: CategoryFilter) throws -> BudgetPresentationState {
        return BudgetPresentationState(
            budget: try mapBudgetPresentation(from: budgetData, for: monthYear),
            monthYear: monthYear,
            filter: map(categoryFilter: filter),
            canGoToPreviousMonth: mapCanGoToPreviousMonth(from: monthYear, budgetStart: budgetData.start),
            canGoToNextMonth: mapCanGoToNextMonth(from: monthYear, budgetEnd: budgetData.end)
        )
    }

    func mapBudgetPresentation(from budgetData: BudgetData, for monthYear: MonthYear) throws -> BudgetPresentation {
        return BudgetPresentation(
            id: ID<BudgetPresentation>(budgetData.id),
            monthYear: monthYear,
            months: mapMonths(from: budgetData.start, to: budgetData.end, for: monthYear),
            readyToAssign: try mapReadyToAssign(for: monthYear, from: budgetData),
            categoryGroups: map(categoryGroups: budgetData.categoryGroups),
            creditCardPaymentGroup: map(creditCardPaymentGroup: budgetData.creditCardPaymentGroup)
        )
    }
    
    func firstMonth(of budgetStart: MonthYear) -> MonthYear {
        MonthYear(month: 1, year: budgetStart.year)
    }
    
    func lastMonth(of budgetEnd: MonthYear) -> MonthYear {
        MonthYear(month: 12, year: budgetEnd.year)
    }
    
    func mapMonths(from budgetStart: MonthYear, to budgetEnd: MonthYear, for activeMonthYear: MonthYear) -> [MonthPresentation] {
        (firstMonth(of: budgetStart)...lastMonth(of: budgetEnd)).map { monthYear in
            map(monthYear: monthYear, activeMonthYear: activeMonthYear, budgetStart: budgetStart, budgetEnd: budgetEnd)
        }
    }
    
    func map(
        monthYear: MonthYear,
        activeMonthYear: MonthYear,
        budgetStart: MonthYear,
        budgetEnd: MonthYear
    ) -> MonthPresentation {
        return MonthPresentation(
            id: ID<MonthPresentation>(monthYear.id),
            monthYear: monthYear,
            isDisabled: mapIsDisabled(for: monthYear, from: budgetStart, and: budgetEnd),
            isCurrentMonth: monthYear == .currentMonthYear,
            foregroundColor: mapForegroundColor(for: monthYear, and: activeMonthYear),
            backgroundColor: mapBackgroundColor(for: monthYear, and: activeMonthYear)
        )
    }
    
    func mapIsDisabled(for monthYear: MonthYear, from budgetStart: MonthYear, and budgetEnd: MonthYear) -> Bool {
        if  monthYear.year == budgetStart.year && monthYear.month < budgetStart.month {
            return true
        }
        
        if monthYear.year == budgetEnd.year && monthYear.month > budgetEnd.month {
            return true
        }
        return false
    }
    
    func mapForegroundColor(for monthYear: MonthYear, and activeMonthYear: MonthYear) -> Color {
        switch (monthYear == activeMonthYear, monthYear == .currentMonthYear) {
        case (true, true): .white
        case (true, false): .white
        case (false, true): .accentColor
        case (false, false): .accentColor
        }
    }

    func mapBackgroundColor(for monthYear: MonthYear, and activeMonthYear: MonthYear) -> Color {
        switch (monthYear == activeMonthYear, monthYear == .currentMonthYear) {
        case (true, true): .accentColor
        case (true, false): .accentColor
        case (false, true): .secondary.opacity(0.2)
        case (false, false): .clear
        }
    }

    func map(categoryFilter: CategoryFilter) -> CategoryFilterPresentation {
        switch categoryFilter {
        case .allCategories:
            return .allCategories
        case .underfunded:
            return .underfunded
        case .moneyAvailable:
            return .moneyAvailable
        }
    }
    
    func mapCanGoToPreviousMonth(from monthYear: MonthYear, budgetStart: MonthYear) -> Bool {
        monthYear > budgetStart
    }

    func mapCanGoToNextMonth(from monthYear: MonthYear, budgetEnd: MonthYear) -> Bool {
        monthYear < budgetEnd
    }
    
    // TODO: Pass currency/formatting settings in here and incorpoate into formatting logic
    // Find the formatted() paramaters for currency and decimal point style and placement  or is this handled by the framwork for location? Way to override? If yes to all, set defaults in settings based on locale etc but override here...

    func mapReadyToAssign(for monthYear: MonthYear, from budgetData: BudgetData) throws -> ReadyToAssignPresentation {
        guard let readyToAssign = budgetData.readyToAssign[monthYear] else {
            throw BudgetError.dataError
        }
        
        return ReadyToAssignPresentation(
            readyToAssignFromLastMonth: readyToAssign.availableToAssignFromLastMonth.formatted(.currency(code: "GBP")),
            cashOverspendingFromLastMonth: readyToAssign.cashOverspendingLastMonth.formatted(.currency(code: "GBP")),
            inflowThisMonth: readyToAssign.inflowThisMonth.formatted(.currency(code: "GBP")),
            assignedThisMonth: readyToAssign.assignedThisMonth.formatted(.currency(code: "GBP")),
            assignedInFuture: readyToAssign.assignedInFuture.formatted(.currency(code: "GBP")),
            readyToAssignThisMonth: readyToAssign.readyToAssignThisMonth.formatted(.currency(code: "GBP")),
            lightModeForegroundColor: mapLightModeForegroundColor(for: readyToAssign.readyToAssignThisMonth),
            darkModeForegroundColor: mapDarkModeForegroundColor(for: readyToAssign.readyToAssignThisMonth),
            lightModeBackgroundColor: mapLightModeBackgroundColor(for: readyToAssign.readyToAssignThisMonth),
            darkModeBackgroundColor: mapDarkModeBackgroundColor(for: readyToAssign.readyToAssignThisMonth),
            message: mapReadyToAssignMessage(for: readyToAssign.readyToAssignThisMonth)
        )
    }
    
    func map(categoryGroups: [CategoryGroupRow]) -> [CategoryGroupPresentation] {
        return categoryGroups.map { categoryGroup in
            map(categoryGroup: categoryGroup)
        }
    }
    
    func map(categoryGroup: CategoryGroupRow) -> CategoryGroupPresentation {
        return CategoryGroupPresentation(
            id: ID<CategoryGroupPresentation>(categoryGroup.id),
            name: categoryGroup.name,
            isHidden: categoryGroup.isHidden,
            assignedTotal: categoryGroup.assignedTotal.mapValues { $0.formatted(.currency(code: "GBP")) },
            activityTotal: categoryGroup.activityTotal.mapValues { $0.formatted(.currency(code: "GBP")) },
            availableTotal: categoryGroup.availableTotal.mapValues { $0.formatted(.currency(code: "GBP")) },
            categories: map(categories: categoryGroup.categories)
        )
    }
    
    func map(categories: [CategoryRow]) -> [CategoryRowPresentation<CategoryAssignedPresentation, CategoryActivityPresentation, CategoryAvailablePresentation>] {
        return categories.map { category in
            map(category: category)
        }
    }
    
    func map(category: CategoryRow) -> CategoryRowPresentation<CategoryAssignedPresentation, CategoryActivityPresentation, CategoryAvailablePresentation> {
        return CategoryRowPresentation(
            id: ID<BudgetRowTag>(category.id),
            name: category.name,
            notes: category.notes,
            isHidden: category.isHidden,
            assigned: mapAssigned(for: category),
            activity: mapActivity(for: category),
            available: mapAvailable(for: category)
        )
    }
    
    func mapAssigned(for category: CategoryRow) -> [MonthYear: CategoryAssignedPresentation] {
        return category.assigned.mapValues { assigned in
            CategoryAssignedPresentation(
                assignedThisMonth: assigned.assignedThisMonth.formatted(.currency(code: "GBP")),
                assignedLastMonth: assigned.assignedLastMonth.formatted(.currency(code: "GBP")),
                averageAssigned: assigned.averageAssigned.formatted(.currency(code: "GBP")),
                spentLastMonth: assigned.spentLastMonth.formatted(.currency(code: "GBP")),
                averageSpent: assigned.averageSpent.formatted(.currency(code: "GBP"))
            )
        }
    }
    
    func mapActivity(for category: CategoryRow) -> [MonthYear: CategoryActivityPresentation] {
        return category.activity.mapValues { activity in
            CategoryActivityPresentation(
                activityTotal: activity.total.formatted(.currency(code: "GBP")),
                transactions: map(transactions: activity.transactions)
            )
        }
    }
    
    func map(transactions: [BudgetTransaction]) -> [TransactionPresentation] {
        transactions.map { transaction in
            TransactionPresentationMapper.map(transaction: transaction)
        }
    }
    
    func mapAvailable(for category: CategoryRow) -> [MonthYear: CategoryAvailablePresentation] {
        return category.available.mapValues { available in
            CategoryAvailablePresentation(
                total: available.total.formatted(.currency(code: "GBP")),
                cashFromLastMonth: available.cashFromLastMonth.formatted(.currency(code: "GBP")),
                assignedThisMonth: available.assignedThisMonth.formatted(.currency(code: "GBP")),
                cashSpendingThisMonth: available.cashSpendingThisMonth.formatted(.currency(code: "GBP")),
                message: available.message,
                lightModeForegroundColor: mapLightModeForegroundColor(for: available.total),
                lightModeBackgroundColor: mapLightModeBackgroundColor(for: available.total),
                darkModeForegroundColor: mapDarkModeForegroundColor(for: available.total),
                darkModeBackgroundColor: mapDarkModeBackgroundColor(for: available.total),
                maxAvailableForReassignment: NSDecimalNumber(decimal: available.total).doubleValue
            )
        }
    }
    
    func mapLightModeForegroundColor(for availableTotal: Decimal) -> Color {
        switch availableTotal {
        case ..<0.00:
            return .red.mix(with: .primary, by: 0.6)
        case 0.00:
            return .secondary
        case 0.01...:
            return .green.mix(with: .primary, by: 0.6)
        default:
            return .secondary
        }
    }
    
    func mapDarkModeForegroundColor(for availableTotal: Decimal) -> Color {
        switch availableTotal {
        case ..<0.00:
            return .red.mix(with: .primary, by: 0.9)
        case 0.00:
            return .secondary.mix(with: .primary, by: 0.6)
        case 0.01...:
            return .green.mix(with: .primary, by: 0.9)
        default:
            return .secondary.mix(with: .primary, by: 0.6)
        }
    }
    
    func mapLightModeBackgroundColor(for availableTotal: Decimal) -> Color {
        switch availableTotal {
        case ..<0.00:
            return .red.mix(with: Color(.systemBackground), by: 0.8)
        case 0.00:
            return .secondary.mix(with: Color(.systemBackground), by: 0.9)
        case 0.01...:
            return .green.mix(with: Color(.systemBackground), by: 0.8)
        default:
            return .secondary.mix(with: Color(.systemBackground), by: 0.9)
        }
    }
    
    func mapDarkModeBackgroundColor(for availableTotal: Decimal) -> Color {
        switch availableTotal {
        case ..<0.00:
            return .red.mix(with: Color(.systemBackground), by: 0.2)
        case 0.00:
            return .secondary.mix(with: Color(.systemBackground), by: 0.5)
        case 0.01...:
            return .green.mix(with: Color(.systemBackground), by: 0.2)
        default:
            return .secondary.mix(with: Color(.systemBackground), by: 0.5)
        }
    }
    
    func mapReadyToAssignMessage(for readyToAssignThisMonth: Decimal) -> String {
        switch readyToAssignThisMonth {
        case ..<0.00:
            "You assigned more than you have"
        case 0.00:
            "All Money Assigned"
        case 0.01...:
            "Ready to Assign"
        default:
            "Error State"
        }
    }
    
    // MARK: Credit Card Payments
    
    func map(creditCardPaymentGroup: CreditCardPaymentGroupRow) -> CreditCardPaymentGroupPresentation {
        return CreditCardPaymentGroupPresentation(
            id: ID<CreditCardPaymentGroupPresentation>(creditCardPaymentGroup.id),
            name: creditCardPaymentGroup.name,
            isHidden: false,
            assignedTotal: creditCardPaymentGroup.assignedTotals.mapValues { $0.formatted(.currency(code: "GBP")) },
            activityTotal: creditCardPaymentGroup.activityTotals.mapValues { $0.formatted(.currency(code: "GBP")) },
            availableTotal: creditCardPaymentGroup.availableTotals.mapValues { $0.formatted(.currency(code: "GBP")) },
            categories: map(creditCardPayments: creditCardPaymentGroup.creditCardPayments)
        )
    }
    
    func map(creditCardPayments: [CreditCardPaymentRow]) -> [CreditCardRowPresentation<CreditCardAssignedPresentation, CreditCardActivityPresentation, CreditCardAvailablePresentation>] {
        return creditCardPayments.map { payment in
            return map(creditCardPayment: payment)
        }
    }
    
    func map(creditCardPayment: CreditCardPaymentRow) -> CreditCardRowPresentation<CreditCardAssignedPresentation, CreditCardActivityPresentation, CreditCardAvailablePresentation> {
        return CreditCardRowPresentation(
            id: ID<BudgetRowTag>(creditCardPayment.id),
            name: creditCardPayment.name,
            isHidden: creditCardPayment.isHidden,
            assigned: mapCreditCardAssigned(for: creditCardPayment),
            activity: mapCreditCardActivity(for: creditCardPayment),
            available: mapCreditCardAvailable(for: creditCardPayment)
        )
    }
    
    func mapCreditCardAssigned(for creditCardPayment: CreditCardPaymentRow) -> [MonthYear: CreditCardAssignedPresentation] {
        return creditCardPayment.assigned.mapValues {
            CreditCardAssignedPresentation(
                assignedThisMonth: $0.assignedThisMonth.formatted(.currency(code: "GBP")),
                assignedLastMonth: $0.assignedLastMonth.formatted(.currency(code: "GBP")),
                averageAssigned: $0.averageAssigned.formatted(.currency(code: "GBP")),
                paidLastMonth: $0.paidLastMonth.formatted(.currency(code: "GBP")),
                averagePaid: $0.averagePaid.formatted(.currency(code: "GBP"))
            )
        }
    }
    
    func mapCreditCardActivity(for creditCardPayment: CreditCardPaymentRow) -> [MonthYear: CreditCardActivityPresentation] {
        return creditCardPayment.activity.mapValues {
            CreditCardActivityPresentation(
                spending: $0.spending.formatted(.currency(code: "GBP")),
                returns: $0.returns.formatted(.currency(code: "GBP")),
                totalSpending: $0.totalSpending.formatted(.currency(code: "GBP")),
                fundedSpending: $0.fundedSpending.formatted(.currency(code: "GBP")),
                paymentsAndReturns: $0.paymentsAndReturns.formatted(.currency(code: "GBP")),
                activityTotal: $0.totalActivity.formatted(.currency(code: "GBP")),
                transactions: $0.transactions.map { TransactionPresentationMapper.map(transaction: $0) }
            )
        }
    }
    
    func mapCreditCardAvailable(for creditCardPayment: CreditCardPaymentRow) -> [MonthYear: CreditCardAvailablePresentation] {
        return creditCardPayment.available.mapValues { available in
            CreditCardAvailablePresentation(
                total: available.total.formatted(.currency(code: "GBP")),
                cashFromLastMonth: available.cashFromLastMonth.formatted(.currency(code: "GBP")),
                assignedThisMonth: available.assignedThisMonth.formatted(.currency(code: "GBP")),
                cashSpendingThisMonth: available.cashSpendingThisMonth.formatted(.currency(code: "GBP")),
                message: available.message,
                lightModeForegroundColor: mapLightModeForegroundColor(for: available.total),
                lightModeBackgroundColor: mapLightModeBackgroundColor(for: available.total),
                darkModeForegroundColor: mapDarkModeForegroundColor(for: available.total),
                darkModeBackgroundColor: mapDarkModeBackgroundColor(for: available.total),
                maxAvailableForReassignment: NSDecimalNumber(decimal: available.total).doubleValue
            )
        }
    }
}
