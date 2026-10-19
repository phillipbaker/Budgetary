//
//  BudgetRowMapper.swift
//  Budgetary
//
//  Created by Phillip Baker on 25/10/2024.
//

import Foundation

public final class BudgetRowMapper: Sendable {
    // MARK: - Budget Data
    
    func mapBudgetData(from data: BudgetDataPlain) -> BudgetData {
        return BudgetData(
            id: ID<BudgetData>(data.budgetPlain.id),
            readyToAssign: mapReadyToAssign(from: data),
            categoryGroups: map(categoryGroupsPlain: data.categoryGroupsPlain, from: data),
            creditCardPaymentGroup: mapCreditCardPaymentGroup(from: data),
            settings: mapBudgetSettings(plain: data.budgetPlain.settings),
            start: mapBudgetStart(from: data),
            end: mapBudgetEnd(from: data)
        )
    }

    // MARK: - Ready To Assign

    func mapReadyToAssign(from data: BudgetDataPlain) -> [MonthYear: ReadyToAssign] {
        var readyToAssign: [MonthYear: ReadyToAssign] = [:]
        
        let categories = data.categoryGroupsPlain.flatMap(\.categories)
        let transactions = data.budgetAccountsPlain.flatMap(\.transactions)
        
        for monthYear in budgetRange(from: data) {
            let previousMonth = monthYear.advanced(by: -1)
            
            // Inflows for monthYear
            var readyToAssignFromLastMonth: Decimal = 0.00
            
            if let lastMonth = readyToAssign[previousMonth] {
                readyToAssignFromLastMonth = lastMonth.availableToAssignFromLastMonth + lastMonth.inflowThisMonth - lastMonth.assignedThisMonth - lastMonth.cashOverspendingLastMonth
            }
            
            let inflowThisMonth = inflow(for: monthYear, from: transactions)
            let totalInflowsThisMonth = readyToAssignFromLastMonth + inflowThisMonth
            
            // Outflows for monthYear
            let cashOverspendingLastMonth = cashOverspendingLastMonth(for: monthYear, from: data)
            let assignedThisMonth = assignedThisMonth(for: monthYear, in: categories)
            let assignedInFuture: Decimal = {
                // Calculate inflow/outflow balance for current month excluding assignedInFuture
                let currentMonthReadyToAssignBalance = (readyToAssignFromLastMonth + inflowThisMonth) - (cashOverspendingLastMonth + assignedThisMonth)
                
                // If current month inflow/outflow is negative or zero in isolation, set assignedInFuture to 0 and ignore
                guard currentMonthReadyToAssignBalance > 0 else {
                    return 0.00
                }
                
                // If here, current month has positive inflow/outflow balance
                // Calculate total actually assigned in future months
                let assignedInFutureTotal = self.assignedInFuture(for: monthYear, in: categories)
                
                // Set assignedInFuture be the actual value up to the point it zeros out current month inflow/outflow
                let assignedInFuture = min(currentMonthReadyToAssignBalance, assignedInFutureTotal)
                
                return assignedInFuture
            }()
            
            let totalOutflowsThisMonth = cashOverspendingLastMonth + assignedThisMonth + assignedInFuture
            
            readyToAssign[monthYear] = ReadyToAssign(
                availableToAssignFromLastMonth: readyToAssignFromLastMonth,
                inflowThisMonth: inflowThisMonth,
                totalInflowsThisMonth: totalInflowsThisMonth,
                cashOverspendingLastMonth: cashOverspendingLastMonth,
                assignedThisMonth: assignedThisMonth,
                assignedInFuture: assignedInFuture,
                totalOutflowsThisMonth: totalOutflowsThisMonth,
                readyToAssignThisMonth: totalInflowsThisMonth - totalOutflowsThisMonth
            )
        }
        
        return readyToAssign
    }

    func cashOverspendingLastMonth(for monthYear: MonthYear, from data: BudgetDataPlain) -> Decimal {
        return data.categoryGroupsPlain
            .flatMap { $0.categories }
            .compactMap { mapAvailable(for: $0, from: data)[monthYear.advanced(by: -1)] }
            .filter { $0.total < 0.00 }
            .compactMap { abs($0.total) } // am adding up negative ammounts so it produces a negative amount but I want the +ve total to add to other deductions on the outflows side of readyToAssign
            .reduced
    }

    func inflow(for monthYear: MonthYear, from transactions: [TransactionPlain]) -> Decimal {
        return transactions
            .filter { $0.categoryID == .init() } // inflow TODO: Figure out how Inflow category works/maps
            .filtered(by: monthYear)
            .mappedToAmounts
            .reduced
    }

    func assignedThisMonth(for monthYear: MonthYear, in categories: [CategoryPlain]) -> Decimal {
        return categories
            .mappedToAssignedAmounts(for: monthYear)
            .reduced
    }

    // Calculated the actual value of future assignments
    func assignedInFuture(for monthYear: MonthYear, in categories: [CategoryPlain]) -> Decimal {
        return categories
            .flatMap { $0.assigned }// [(MonthYear, Decimal)] Flattens to tuples
            .filter { $0.key > monthYear } // [(MonthYear, Decimal)] Filtered
            .map { $0.value } // [Decimal]
            .reduced
    }

    // MARK: - Credit Card Payments Plain -> Rows
    
    func mapCreditCardPaymentGroup(from data: BudgetDataPlain) -> CreditCardPaymentGroupRow {
        let creditCardPayments = map(paymentsPlain: data.creditCardPaymentGroupPlain.cardPayments, from: data)
        return CreditCardPaymentGroupRow(
            id: ID<CreditCardPaymentGroupRow>(data.creditCardPaymentGroupPlain.id),
            name: data.creditCardPaymentGroupPlain.name,
            assignedTotals: mapGroupAssignedTotal(for: creditCardPayments),
            activityTotals: mapGroupActivityTotal(for: creditCardPayments),
            availableTotals: mapGroupAvailableTotal(for: creditCardPayments),
            creditCardPayments: creditCardPayments
        )
    }
    
    func map(paymentsPlain: [CreditCardPaymentPlain], from data: BudgetDataPlain) -> [CreditCardPaymentRow] {
        paymentsPlain.map { cardPayment in
            map(paymentPlain: cardPayment, from: data)
        }
    }
    
    func map(paymentPlain: CreditCardPaymentPlain, from data: BudgetDataPlain) -> CreditCardPaymentRow {
        let activity = mapActivity(for: paymentPlain, from: data)
        
        return CreditCardPaymentRow(
            id: ID<CreditCardPaymentRow>(paymentPlain.id),
            name: paymentPlain.name,
            isHidden: paymentPlain.isHidden,
            assigned: mapAssigned(for: paymentPlain, from: data),
            activity: activity,
            available: mapAvailable(for: paymentPlain, and: activity, from: data)
        )
    }
    
    // MARK: Assigned

    func mapAssigned(for cardPaymentPlain: CreditCardPaymentPlain, from data: BudgetDataPlain) -> [MonthYear: CreditCardAssigned] {
        var assigned: [MonthYear: CreditCardAssigned] = [:]
        
        var paymentHistory: [MonthYear: Decimal] = [:]
        
        for monthYear in mapBudgetStart(from: data)..<MonthYear.currentMonthYear.advanced(by: -1) {
            paymentHistory[monthYear] = payment(for: cardPaymentPlain, in: monthYear, from: data)
        }

        let totalAssignedToLastMonth = cardPaymentPlain.assigned.values.reduce(0, +)
        let totalPaymentsToLastMonth = paymentHistory.values.reduce(0, +)
        let monthCount = Decimal(cardPaymentPlain.assigned.count)
        
        for monthYear in budgetRange(from: data) {
            assigned[monthYear] = CreditCardAssigned(
                assignedThisMonth: cardPaymentPlain.assigned[monthYear] ?? 0,
                assignedLastMonth: cardPaymentPlain.assigned[monthYear.advanced(by: -1)] ?? 0.00,
                averageAssigned: totalAssignedToLastMonth / monthCount,
                paidLastMonth: paymentHistory[monthYear.advanced(by: -1)] ?? 0.00,
                averagePaid: totalPaymentsToLastMonth / monthCount
            )
        }
        
        return assigned
    }

    func mapGroupAssignedTotal(for cardPayments: [CreditCardPaymentRow]) -> [MonthYear: Decimal] {
        var totals: [MonthYear: Decimal] = [:]
        for payment in cardPayments {
            for (monthYear, assigned) in payment.assigned {
                if let existingValue = totals[monthYear] {
                    totals[monthYear] = existingValue + assigned.assignedThisMonth
                } else {
                    totals[monthYear] = assigned.assignedThisMonth
                }
            }
        }
        return totals
    }
    
    // MARK: Activity
    
    func mapActivity(for creditCardPaymentPlain: CreditCardPaymentPlain, from data: BudgetDataPlain) -> [MonthYear: CreditCardActivity] {
        var activity: [MonthYear: CreditCardActivity] = [:]
        var transactions: [BudgetTransaction] = []
        
        for account in data.budgetAccountsPlain {
            transactions.append(
                contentsOf: TransactionMapper.mapTransactions(
                    for: account,
                    fromPayees: data.payeesPlain,
                    andCategoryGroups: data.categoryGroupsPlain
                )
            )
        }
        
        for monthYear in budgetRange(from: data) {
            let monthlyCardTransactions = transactions
                .filtered(by: monthYear)
                .filtered(byAccount: creditCardPaymentPlain.accountID)
            
            // All outflow transactions to payees (i.e. not transfers out)
            let spending = monthlyCardTransactions
                .filteredBySpending
                .filteredByOutflows
                .mappedToAmounts
                .reduced
            
            // All inflow transactions from payess (not transfers)
            let returns = monthlyCardTransactions
                .filteredBySpending
                .filteredByInflows
                .mappedToAmounts
                .reduced
            
            let categories = data.categoryGroupsPlain.flatMap { $0.categories }
            
            let dictionary = Dictionary(grouping: monthlyCardTransactions, by: { $0.category })
            let spendingByCategory = dictionary.mapValues { $0.compactMap { $0.amount.value }.reduce(0.00,+) }
            
            var fundedSpending: Decimal = 0.00
            
            for (category, spending) in spendingByCategory {
                guard let assigned = categories.first(where: { $0.id == ID<CategoryPlain>(category?.id) })?.assigned[monthYear] else { continue }
                fundedSpending += min(assigned, spending)
            }

            // Payments and returns are transfers (payee is another account).
            // Signed from the payment set-aside's perspective, which is the
            // opposite of the account balance: a payment is a card inflow but
            // consumes the money set aside to pay the card, so it is negative.
            // TODO: Returns?
            let paymentsAndReturns = monthlyCardTransactions
                .filteredByTransfers
                .reduce(Decimal(0)) { running, transaction in
                    switch transaction.amount {
                    case .inflow(let amount):  return running - amount   // payment: consumes the set-aside
                    case .outflow(let amount): return running + amount   // transfer out / adjustment
                    }
                }

            // TODO: calculate here or use spending and returns totals? Do both and check they match or do that in tests?
            
            activity[monthYear] = CreditCardActivity(
                spending: spending,
                returns: returns,
                totalSpending: spending - returns, // TODO: check if + or - is correct here
                fundedSpending: fundedSpending,
                paymentsAndReturns: paymentsAndReturns,
                totalActivity: fundedSpending + paymentsAndReturns, // TODO: check if + or - is correct here
                transactions: monthlyCardTransactions
            )
        }
        
        return activity
    }
    
    func mapSpending(for account: BudgetAccountPlain, in monthYear: MonthYear) -> Decimal {
        return account.transactions
            .filteredByOutflows
            .filtered(by: monthYear)
            .mappedToAmounts
            .reduced
    }
    
    func mapReturns(for account: BudgetAccountPlain, in monthYear: MonthYear) -> Decimal {
        return account.transactions
            .filteredByInflows
            .filtered(by: monthYear)
            .mappedToAmounts
            .reduced
    }
    
    func mapGroupActivityTotal(for cardPayments: [CreditCardPaymentRow]) -> [MonthYear: Decimal] {
        var totals: [MonthYear: Decimal] = [:]
        
        for payment in cardPayments {
            for (monthYear, activity) in payment.activity {
                if let existingValue = totals[monthYear] {
                    totals[monthYear] = existingValue + activity.totalActivity
                } else {
                    totals[monthYear] = activity.totalActivity
                }
            }
        }
        return totals
    }
    
    // MARK: Available

    func mapAvailable(for cardPaymentPlain: CreditCardPaymentPlain, and activity: [MonthYear: CreditCardActivity], from data: BudgetDataPlain) -> [MonthYear: CreditCardAvailable] {
        var available: [MonthYear: CreditCardAvailable] = [:]
        
        for monthYear in budgetRange(from: data) {
            let previousMonth = monthYear.advanced(by: -1)
            var availableFromLastMonth: Decimal = 0.00
            
            if let availableFromPreviousMonth = available[previousMonth]?.total, availableFromPreviousMonth > 0.00 {
                availableFromLastMonth = availableFromPreviousMonth
            }
            
            let assignedThisMonth = cardPaymentPlain.assigned[monthYear] ?? 0.00
            let activityThisMonth = activity[monthYear]?.totalActivity ?? 0.00

            available[monthYear] = CreditCardAvailable(
                total: availableFromLastMonth + assignedThisMonth + activityThisMonth,
                cashFromLastMonth: availableFromLastMonth,
                assignedThisMonth: assignedThisMonth,
                cashSpendingThisMonth: 0.00,
                message: ""
            )
        }
        
        return available
    }
    
    // TODO: - this is returning a stub. Identify payments from given month - how are these different? transfer from one account to another - what if paid from an account outside of budget (i..e by someone else)? Needs to exlude refunds
    func payment(for cardPaymentPlain: CreditCardPaymentPlain, in monthYear: MonthYear, from data: BudgetDataPlain) -> Decimal {
        return 99.99
    }
    
    func mapGroupAvailableTotal(for cardPayments: [CreditCardPaymentRow]) -> [MonthYear: Decimal] {
        var totals: [MonthYear: Decimal] = [:]
        
        for payment in cardPayments {
            for (monthYear, available) in payment.available {
                if let existingValue = totals[monthYear] {
                    totals[monthYear] = existingValue + available.total
                } else {
                    totals[monthYear] = available.total
                }
            }
        }
        return totals
    }

    // MARK: - Category Groups Plain -> Rows
    
    func map(categoryGroupPlain: CategoryGroupPlain, from data: BudgetDataPlain) -> CategoryGroupRow {
        let categories = map(categoriesPlain: categoryGroupPlain.categories, from: data)
        return CategoryGroupRow(
            id: ID<CategoryGroupRow>(categoryGroupPlain.id),
            name: categoryGroupPlain.name,
            isHidden: categoryGroupPlain.isHidden,
            assignedTotal: mapGroupAssignedTotal(for: categories),
            activityTotal: mapGroupActivityTotal(for: categories),
            availableTotal: mapGroupAvailableTotal(for: categories),
            categories: categories
        )
    }
    
    func map(categoryGroupsPlain: [CategoryGroupPlain], from data: BudgetDataPlain) -> [CategoryGroupRow] {
        categoryGroupsPlain.map { categoryGroupPlain in
            map(categoryGroupPlain: categoryGroupPlain, from: data)
        }
    }
    
    func map(categoriesPlain: [CategoryPlain], from data: BudgetDataPlain) -> [CategoryRow] {
        categoriesPlain.map { categoryPlain in
            map(categoryPlain: categoryPlain, from: data)
        }
    }
    
    func map(categoryPlain: CategoryPlain, from data: BudgetDataPlain) -> CategoryRow {
        return CategoryRow(
            id: ID<CategoryRow>(categoryPlain.id),
            name: categoryPlain.name,
            notes: categoryPlain.notes,
            isHidden: categoryPlain.isHidden,
            assigned: mapAssigned(for: categoryPlain, from: data),
            activity: mapActivity(for: categoryPlain, from: data),
            available: mapAvailable(for: categoryPlain, from: data)
        )
    }
    
    // MARK: Assigned

    func mapAssigned(for category: CategoryPlain, from data: BudgetDataPlain) -> [MonthYear: Assigned] {
        var assigned: [MonthYear: Assigned] = [:]
        
        var activityHistory: [MonthYear: Decimal] = [:]
        for monthYear in mapBudgetStart(from: data)..<MonthYear.currentMonthYear.advanced(by: -1) {
            activityHistory[monthYear] = activity(for: category, in: monthYear, from: data)
        }
        
        // TODO: Make these actually go to last month - function for activity in range rather than monthYear?
        let totalAssignedToLastMonth = category.assigned.values.reduce(0, +)
        let totalActivityToLastMonth = activityHistory.values.reduce(0, +)
        let monthCount = Decimal(category.assigned.count)
        
        for monthYear in budgetRange(from: data) {
            assigned[monthYear] = Assigned(
                assignedThisMonth: category.assigned[monthYear] ?? 0.00,
                assignedLastMonth: category.assigned[monthYear.advanced(by: -1)] ?? 0.00,
                spentLastMonth: activityHistory[monthYear.advanced(by: -1)] ?? 0.00,
                averageAssigned: totalAssignedToLastMonth / monthCount,
                averageSpent: totalActivityToLastMonth / monthCount
            )
        }
        return assigned
    }
    
    func mapGroupAssignedTotal(for categories: [CategoryRow]) -> [MonthYear: Decimal] {
        var totals: [MonthYear: Decimal] = [:]
        
        for category in categories {
            for (monthYear, assigned) in category.assigned {
                if let existingValue = totals[monthYear] {
                    totals[monthYear] = existingValue + assigned.assignedThisMonth
                } else {
                    totals[monthYear] = assigned.assignedThisMonth
                }
            }
        }
        return totals
    }

    // MARK: Activity

    func activity(for category: CategoryPlain, in monthYear: MonthYear, from data: BudgetDataPlain) -> Decimal {
        return data.budgetAccountsPlain
            .transactions
            .filtered(by: monthYear)
            .filtered(by: category.id)
            .mappedToAmounts
            .reduced
    }

    func mapActivity(for category: CategoryPlain, from data: BudgetDataPlain) -> [MonthYear: Activity] {
        var activity: [MonthYear: Activity] = [:]
        var transactions: [BudgetTransaction] = []
        
        for account in data.budgetAccountsPlain {
            transactions.append(
                contentsOf: TransactionMapper.mapTransactions(
                    for: account,
                    fromPayees: data.payeesPlain,
                    andCategoryGroups: data.categoryGroupsPlain
                )
            )
        }
        
        for monthYear in budgetRange(from: data) {
            let monthlyCategoryTransactions = transactions
                .filtered(by: monthYear)
                .filtered(by: category.id)
            
            let total = monthlyCategoryTransactions
                .mappedToAmounts
                .reduced
            
            activity[monthYear] = Activity(total: total, transactions: monthlyCategoryTransactions)
        }
        
        return activity
    }

    func mapGroupActivityTotal(for categories: [CategoryRow]) -> [MonthYear: Decimal] {
        var totals = [MonthYear: Decimal]()
        
        for category in categories {
            for (monthYear, activity) in category.activity {
                if let existingValue = totals[monthYear] {
                    totals[monthYear] = existingValue + activity.total
                } else {
                    totals[monthYear] = activity.total
                }
            }
        }
        return totals
    }

    // MARK: Available

    func mapAvailable(for category: CategoryPlain, from data: BudgetDataPlain) -> [MonthYear: Available] {
        var available: [MonthYear: Available] = [:]
        
        for monthYear in budgetRange(from: data) {
            let previousMonth = monthYear.advanced(by: -1)
            var cashFromLastMonth: Decimal = 0.00
            
            if let availableFromPreviousMonth = available[previousMonth]?.total, availableFromPreviousMonth > 0.00 {
                cashFromLastMonth = availableFromPreviousMonth
            }
            
            let assignedThisMonth = category.assigned[monthYear] ?? 0.00
            let cashSpendingThisMonth = activity(for: category, in: monthYear, from: data)
            let total = cashFromLastMonth + assignedThisMonth - cashSpendingThisMonth
            
            available[monthYear] = Available(
                total: total,
                cashFromLastMonth: cashFromLastMonth,
                assignedThisMonth: assignedThisMonth,
                cashSpendingThisMonth: cashSpendingThisMonth,
                message: ""
            )
        }
        return available
    }
    
    func mapGroupAvailableTotal(for categories: [CategoryRow]) -> [MonthYear: Decimal] {
        var totals: [MonthYear: Decimal] = [:]
        
        for category in categories {
            for (monthYear, available) in category.available {
                if let existingValue = totals[monthYear] {
                    totals[monthYear] = existingValue + available.total
                    
                } else {
                    totals[monthYear] = available.total
                }
            }
        }
        return totals
    }
    
    // MARK: - Budget Settings
    
    func mapBudgetSettings(plain: BudgetSettingsPlain) -> BudgetSettings {
        return BudgetSettings(
            name: plain.name,
            curreny: plain.curreny,
            currencyFormet: plain.currencyFormet,
            numberFormat: plain.numberFormat,
            dateFormat: plain.dateFormat
        )
    }

    // MARK: - Budget Range

    func budgetRange(from data: BudgetDataPlain) -> ClosedRange<MonthYear> {
        return mapBudgetStart(from: data)...mapBudgetEnd(from: data)
    }

    func mapBudgetStart(from data: BudgetDataPlain) -> MonthYear {
        let earliestActivityMonthYear = data.budgetAccountsPlain
            .transactions
            .compactMap { MonthYear(from: $0.date) } // [MonthYear]
            .min() // MonthYear?
        ?? MonthYear(from: .now.advanced(by: Double(-365 * 24 * 60 * 60)))
        
        let earliestAssignedMonthYear = data.categoryGroupsPlain
            .flatMap { $0.categories } // [Categories]
            .flatMap { $0.assigned } // [MonthYear: Decimal]
            .compactMap { $0.key } // [MonthYear]
            .min() // MonthYear?
        ?? MonthYear(from: .now.advanced(by: Double(-365 * 24 * 60 * 60)))
        
        return min(earliestActivityMonthYear, earliestAssignedMonthYear)
    }

    func mapBudgetEnd(from data: BudgetDataPlain) -> MonthYear {
        let latestAssignedMonthYear = data.categoryGroupsPlain
            .flatMap { $0.categories } // [Categories]
            .flatMap { $0.assigned } // [MonthYear: Decimal]
            .compactMap { $0.key }.sorted(by: <) // [MonthYear] ordered chronologically
            .last ?? .currentMonthYear // MonthYear?
        return max(latestAssignedMonthYear.advanced(by: 1), .currentMonthYear.advanced(by: 1))
    }
}
