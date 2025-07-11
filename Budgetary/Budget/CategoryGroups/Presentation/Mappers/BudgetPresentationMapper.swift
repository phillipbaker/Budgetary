//
//  BudgetPresentationMapper.swift
//  Budgetary
//
//  Created by Phillip Baker on 24/10/2024.
//

import Foundation
import SwiftUI

//Double(proposedReassignemnt)
//proposedReassignment: NSDecimalNumber(decimal: category.proposedReassignment).doubleValue

public final class BudgetPresentationMapper {
    func map(budget: Budget) -> BudgetPresentation {
        return BudgetPresentation(
            id: budget.id,
            monthYear: budget.monthYear,
            months: map(budgetRange: firstMonth(of: budget.start)...lastMonth(of: budget.end), for: budget),
            filter: map(categoryFilter: budget.filter),
            readyToAssign: mapReadyToAssign(for: budget),
            categoryGroups: map(categoryGroups: budget.categoryGroups),
            start: budget.start,
            end: budget.end
        )
    }
    
    func firstMonth(of budgetStart: MonthYear) -> MonthYear {
        MonthYear(month: 1, year: budgetStart.year)
    }
    
    func lastMonth(of budgetEnd: MonthYear) -> MonthYear {
        MonthYear(month: 12, year: budgetEnd.year)
    }
    
    func map(budgetRange: ClosedRange<MonthYear>, for budget: Budget) -> [MonthPresentation] {
        budgetRange.map { monthYear in
            map(monthYear: monthYear, for: budget)
        }
    }

    func map(monthYear: MonthYear, for budget: Budget) -> MonthPresentation {
        return MonthPresentation(
            id: monthYear.id,
            monthYear: monthYear,
            isDisabled: mapIsDisabled(for: monthYear, in: budget),
            foregroundColor: mapForegroundColor(for: monthYear, in: budget),
            backgroundColor: mapBackgroundColor(for: monthYear, in: budget)
        )
    }

    func mapIsDisabled(for monthYear: MonthYear, in budget: Budget) -> Bool {
        if  monthYear.year == budget.start.year && monthYear.month < budget.start.month {
            return true
        }
        
        if monthYear.year == budget.end.year && monthYear.month > budget.end.month {
            return true
        }
        return false
    }
    
    func mapForegroundColor(for monthYear: MonthYear, in budget: Budget) -> Color {
        switch (monthYear == budget.monthYear, monthYear == .currentMonthYear) {
        case (true, true): .white
        case (true, false): .white
        case (false, true): .accentColor
        case (false, false): .accentColor
        }
    }
    
    func mapBackgroundColor(for monthYear: MonthYear, in budget: Budget) -> Color {
        switch (monthYear == budget.monthYear, monthYear == .currentMonthYear) {
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
    
    // TODO: Pass currency/formatting settings in here and incorpoate into formatting logic
    // Find the formatted() paramaters for currency and decimal point style and placement  or is this handled by the framwork for location? Way to override? If yes to all, set defaults in settings based on locale etc but override here...
    func mapReadyToAssign(for budget: Budget) -> [MonthYear: ReadyToAssignPresentation] {
        return budget.readyToAssign.mapValues { readyToAssign in
            ReadyToAssignPresentation(
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
//                destination: readyToAssign.readyToAssignThisMonth >= 0.00 ? .assignMoney : .coverOverspending
            )
        }
    }
    
    func map(categoryGroups: [CategoryGroup]) -> [CategoryGroupPresentation] {
        return categoryGroups.map { categoryGroup in
            map(categoryGroup: categoryGroup)
        }
    }
    
    func map(categoryGroup: CategoryGroup) -> CategoryGroupPresentation {
        return CategoryGroupPresentation(
            id: categoryGroup.id,
            name: categoryGroup.name,
            isHidden: categoryGroup.isHidden,
            assignedTotal: categoryGroup.assignedTotal.mapValues { $0.formatted(.currency(code: "GBP")) },
            activityTotal: categoryGroup.activityTotal.mapValues { $0.formatted(.currency(code: "GBP")) },
            availableTotal: categoryGroup.availableTotal.mapValues { $0.formatted(.currency(code: "GBP")) },
            categories: map(categories: categoryGroup.categories)
        )
    }
    
    func map(categories: [Category]) -> [CategoryPresentation] {
        return categories.map { category in
            map(category: category)
        }
    }
    
    func map(category: Category) -> CategoryPresentation {
        return CategoryPresentation(
            id: category.id,
            name: category.name,
            notes: category.notes,
            isHidden: category.isHidden,
            assigned: mapAssigned(for: category),
            activity: mapActivity(for: category),
            available: mapAvailable(for: category)
        )
    }
    
    func mapAssigned(for category: Category) -> [MonthYear: AssignedPresentation] {
        return category.assigned.mapValues { assigned in
            AssignedPresentation(
                assignedThisMonth: assigned.assignedThisMonth.formatted(.currency(code: "GBP")),
                assignedLastMonth: assigned.assignedLastMonth.formatted(.currency(code: "GBP")),
                spentLastMonth: assigned.spentLastMonth.formatted(.currency(code: "GBP")),
                averageAssigned: assigned.averageAssigned.formatted(.currency(code: "GBP")),
                averageSpent: assigned.averageSpent.formatted(.currency(code: "GBP"))
            )
        }
    }
    
    func mapActivity(for category: Category) -> [MonthYear: ActivityPresentation] {
        return category.activity.mapValues { activity in
            ActivityPresentation(
                id: UUID().uuidString,
                total: activity.total.formatted(.currency(code: "GBP")),
                transactions: map(transactions: activity.transactions)
            )
        }
    }
    
    func map(transactions: [TransactionEntity]) -> [TransactionPresentation] {
        transactions.map { transaction in
            TransactionPresentationMapper.map(transaction: transaction)
        }
    }
    
    func mapAvailable(for category: Category) -> [MonthYear: AvailablePresentation] {
        return category.available.mapValues { available in
            AvailablePresentation(
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
}
