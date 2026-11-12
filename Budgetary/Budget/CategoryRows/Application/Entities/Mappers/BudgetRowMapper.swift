//
//  BudgetRowMapper.swift
//  Budgetary
//
//  Created by Phillip Baker on 25/10/2024.
//

import Foundation

public final class BudgetRowMapper: Sendable {
    typealias AssignedByCategory = [ID<TransactionCategory>: [MonthYear: Decimal]]
    typealias TransactionsByCategory = [ID<TransactionCategory>: [BudgetTransaction]]
    
    // MARK: - Budget Data
    
    func mapBudgetData(from data: BudgetDataPlain) -> BudgetData {
        let readyToAssignID = data.categoryGroupsPlain.readyToAssignCategoryID
            .map { ID<TransactionCategory>($0) }
        
        let transactions = data.budgetAccountsPlain.flatMap { account in
            TransactionMapper.mapTransactions(for: account, fromPayees: data.payeesPlain, andCategoryGroups: data.categoryGroupsPlain)
        }
        
        let transactionsByCategory = Dictionary(
            grouping: transactions.filteredBySpending.filter { $0.category != nil },
            by: { $0.category!.id }
        )
        
        let budgetRange = budgetRange(
            fromCategoryGroups: data.categoryGroupsPlain,
            creditCardPaymentGroup: data.creditCardPaymentGroupPlain,
            and: transactions
        )
        
        let readyToAssignActivity = activity(
            from: readyToAssignID.flatMap { transactionsByCategory[$0] } ?? [],
            in: budgetRange
        )
        
        let categoryGroupRows = map(categoryGroupsPlain: data.categoryGroupsPlain, using: transactionsByCategory, in: budgetRange)
        
        let assignedByCategory: AssignedByCategory = Dictionary(
            data.categoryGroupsPlain
                .flatMap(\.categories)
                .map { (ID<TransactionCategory>($0.id), $0.assigned) }, uniquingKeysWith: { first, _ in first }
        )

        let creditCardPaymentRows = map(
            paymentsPlain: data.creditCardPaymentGroupPlain.cardPayments,
            using: transactions,
            assignedByCategory: assignedByCategory,
            in: budgetRange
        )
        
        let creditCardPaymentGroup = creditCardPaymentGroup(
            id: data.creditCardPaymentGroupPlain.id,
            name: data.creditCardPaymentGroupPlain.name,
            creditCardPaymentRows: creditCardPaymentRows
        )
        
        let readyToAssign = readyToAssign(
            inflows: readyToAssignActivity,
            categoryGroupRows: categoryGroupRows,
            in: budgetRange
        )

        let settings = map(budgetSettingsPlain: data.budgetPlain.settings)

        return BudgetData(
            id: ID<BudgetData>(data.budgetPlain.id),
            readyToAssign: readyToAssign,
            categoryGroups: categoryGroupRows,
            creditCardPaymentGroup: creditCardPaymentGroup,
            settings: settings,
            range: budgetRange
        )
    }

    // MARK: - Ready To Assign

    func readyToAssign(
        inflows: [MonthYear: Activity],
        categoryGroupRows: [CategoryGroupRow],
        in budgetRange: ClosedRange<MonthYear>
    ) -> [MonthYear: ReadyToAssign] {
        var readyToAssign: [MonthYear: ReadyToAssign] = [:]
        
        let spendingRows = categoryGroupRows
            .filter { $0.kind != .inflow }
            .flatMap(\.categories)
        
        for monthYear in budgetRange {
            // Inflows for monthYear
            var readyToAssignFromLastMonth: Decimal = 0.00
            
            if let lastMonth = readyToAssign[monthYear.advanced(by: -1)] {
                readyToAssignFromLastMonth = lastMonth.availableToAssignFromLastMonth + lastMonth.inflowThisMonth - lastMonth.assignedThisMonth - lastMonth.cashOverspendingLastMonth
            }
            
            let inflowThisMonth = inflows[monthYear]?.total ?? 0
            let totalInflowsThisMonth = readyToAssignFromLastMonth + inflowThisMonth
            
            // Outflows for monthYear
            let cashOverspendingLastMonth = cashOverspendingLastMonth(for: monthYear, in: spendingRows)
            let assignedThisMonth = assignedThisMonth(for: monthYear, in: spendingRows)
            let assignedInFuture: Decimal = {
                // Calculate inflow/outflow balance for current month excluding assignedInFuture
                let currentMonthReadyToAssignBalance = (readyToAssignFromLastMonth + inflowThisMonth) - (cashOverspendingLastMonth + assignedThisMonth)
                
                // If current month inflow/outflow is negative or zero in isolation, set assignedInFuture to 0 and ignore
                guard currentMonthReadyToAssignBalance > 0 else {
                    return 0.00
                }
                
                // If here, current month has positive inflow/outflow balance
                // Calculate total actually assigned in future months
                let assignedInFutureTotal = self.assignedInFuture(for: monthYear, in: spendingRows)
                
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

    func cashOverspendingLastMonth(for monthYear: MonthYear, in spendingCategories: [CategoryRow]) -> Decimal {
        return spendingCategories
            .compactMap { $0.available[monthYear.advanced(by: -1)]?.total }
            .filter { $0 < 0 }
            .map { abs($0) } // sum of negative ammounts converted to +ve total to add to other outflows
            .reduced
    }

    func assignedThisMonth(for monthYear: MonthYear, in categories: [CategoryRow]) -> Decimal {
        return categories
            .mappedToAssignedAmounts(for: monthYear)
            .reduced
    }

    // Calculated the actual value of future assignments
    func assignedInFuture(for monthYear: MonthYear, in categories: [CategoryRow]) -> Decimal {
        return categories
            .flatMap { $0.assigned }// [(MonthYear, Decimal)] Flattens to tuples
            .filter { $0.key > monthYear } // [(MonthYear, Decimal)] Filtered
            .map { $0.value.assignedThisMonth } // [Decimal]
            .reduced
    }

    // MARK: - Credit Card Payments Plain -> Rows
    
    func creditCardPaymentGroup(
        id: ID<CreditCardPaymentGroupPlain>,
        name: String,
        creditCardPaymentRows: [CreditCardPaymentRow]
    ) -> CreditCardPaymentGroupRow {
        return CreditCardPaymentGroupRow(
            id: ID<CreditCardPaymentGroupRow>(id),
            name: name,
            assignedTotals: totalsByMonth(creditCardPaymentRows) { $0.assigned.mapValues(\.assignedThisMonth) },
            activityTotals: totalsByMonth(creditCardPaymentRows) { $0.activity.mapValues(\.totalActivity) },
            availableTotals: totalsByMonth(creditCardPaymentRows) { $0.available.mapValues(\.total) },
            creditCardPayments: creditCardPaymentRows
        )
    }
    
    func map(paymentsPlain: [CreditCardPaymentPlain], using transactions: [BudgetTransaction], assignedByCategory: AssignedByCategory, in budgetRange: ClosedRange<MonthYear>) -> [CreditCardPaymentRow] {
        paymentsPlain.map { cardPayment in
            map(paymentPlain: cardPayment, using: transactions, assignedByCategory: assignedByCategory, in: budgetRange)
        }
    }
    
    func map(paymentPlain: CreditCardPaymentPlain, using transactions: [BudgetTransaction], assignedByCategory: AssignedByCategory, in budgetRange: ClosedRange<MonthYear>) -> CreditCardPaymentRow {
        let activity = activity(for: paymentPlain, using: transactions, assignedByCategory: assignedByCategory, in: budgetRange)
        
        return CreditCardPaymentRow(
            id: ID<CreditCardPaymentRow>(paymentPlain.id),
            name: paymentPlain.name,
            isHidden: paymentPlain.isHidden,
            assigned: assigned(for: paymentPlain, using: activity, in: budgetRange),
            activity: activity,
            available: available(for: paymentPlain, using: activity, in: budgetRange)
        )
    }
    
    // MARK: Assigned

    func assigned(
        for cardPaymentPlain: CreditCardPaymentPlain,
        using activity: [MonthYear : CreditCardActivity],
        in budgetRange: ClosedRange<MonthYear>
    ) -> [MonthYear: CreditCardAssigned] {
        var assigned: [MonthYear: CreditCardAssigned] = [:]
        
        var runningAssigned: Decimal = 0
        var previousAssigned: Decimal = 0
        var runningPaid: Decimal = 0
        var previousPaid: Decimal = 0
        var monthCount: Decimal = 0
        
        for monthYear in budgetRange {
            let assignedThisMonth = cardPaymentPlain.assigned[monthYear] ?? 0
            let paidThisMonth = activity[monthYear]?.payments ?? 0
            
            assigned[monthYear] = CreditCardAssigned(
                assignedThisMonth: assignedThisMonth,
                assignedLastMonth: previousAssigned,
                averageAssigned: monthCount > 0 ? runningAssigned / monthCount : 0,
                paidLastMonth: previousPaid,
                averagePaid: monthCount > 0 ? runningPaid / monthCount : 0
            )
            
            // Add this month so the next month's averages include it
            runningAssigned += assignedThisMonth
            previousAssigned = assignedThisMonth
            runningPaid += paidThisMonth
            previousPaid = paidThisMonth
            monthCount += 1
        }
        
        return assigned
    }
    
    // MARK: Activity
    
    func activity(
        for creditCardPaymentPlain: CreditCardPaymentPlain,
        using transactions: [BudgetTransaction],
        assignedByCategory: AssignedByCategory,
        in budgetRange: ClosedRange<MonthYear>
    ) -> [MonthYear: CreditCardActivity] {
        
        let cardTransactions = transactions.filtered(byAccount: creditCardPaymentPlain.accountID)
        let byMonth = Dictionary(grouping: cardTransactions) { MonthYear(from: $0.date) }
        var activity: [MonthYear: CreditCardActivity] = [:]
        
        for monthYear in budgetRange {
            let monthlyCardTransactions = byMonth[monthYear] ?? []
            let spendingTransactions = monthlyCardTransactions.filteredBySpending
            let transfers = monthlyCardTransactions.filteredByTransfers
            
            // All outflow transactions to regular payees (not transfers)
            let spending = spendingTransactions
                .filteredByOutflows
                .mappedToMagnitudes
                .reduced
            
            // All inflow transactions from regular payees (not transfers)
            let returns = spendingTransactions
                .filteredByInflows
                .mappedToMagnitudes
                .reduced
            
            let spendingByCategory = Dictionary(
                grouping: spendingTransactions,
                by: { $0.category }
            ).mapValues { -$0.netAmount }
            
            // TODO: Funding is capped by this month's `assigned`, not the category's
            // available (which includes rollover), so spending covered by earlier
            // months looks unfunded. Likewise a refund of an unfunded purchase still
            // reduces fundedSpending, pulling the payment set-aside below the card debt.
            // Fixing both needs category available carried across months.
            var fundedSpending: Decimal = 0.00
            
            for (category, spending) in spendingByCategory {
                guard let categoryID = category?.id else { continue }
                let assigned = assignedByCategory[categoryID]?[monthYear] ?? 0
                fundedSpending += min(assigned, spending)
            }
            
            // Transfer inflows from other accounts
            let payments = transfers
                .filteredByInflows
                .mappedToMagnitudes
                .reduced
            
            // Transfer outflows
            let transfersOut = transfers
                .filteredByOutflows
                .mappedToMagnitudes
                .reduced

            activity[monthYear] = CreditCardActivity(
                spending: spending,
                returns: returns,
                fundedSpending: fundedSpending,
                payments: payments,
                transfersOut: transfersOut,
                transactions: monthlyCardTransactions
            )
        }
        
        return activity
    }
    
    // MARK: Available

    func available(for cardPaymentPlain: CreditCardPaymentPlain, using activity: [MonthYear: CreditCardActivity], in budgetRange: ClosedRange<MonthYear>) -> [MonthYear: CreditCardAvailable] {
        var available: [MonthYear: CreditCardAvailable] = [:]
        
        for monthYear in budgetRange {
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

    // MARK: - Category Groups Plain -> Rows
    
    func map(
        categoryGroupsPlain: [CategoryGroupPlain],
        using transactionsByCategory: TransactionsByCategory,
        in budgetRange: ClosedRange<MonthYear>
    ) -> [CategoryGroupRow] {
        categoryGroupsPlain.map { categoryGroupPlain in
            map(categoryGroupPlain: categoryGroupPlain, using: transactionsByCategory, in: budgetRange)
        }
    }
    
    func map(
        categoryGroupPlain: CategoryGroupPlain,
        using transactionsByCategory: TransactionsByCategory,
        in budgetRange: ClosedRange<MonthYear>
    ) -> CategoryGroupRow {
        let categories = map(categoriesPlain: categoryGroupPlain.categories, using: transactionsByCategory, in: budgetRange)
        return CategoryGroupRow(
            id: ID<CategoryGroupRow>(categoryGroupPlain.id),
            name: categoryGroupPlain.name,
            kind: map(categoryGroupKindPlain: categoryGroupPlain.kind),
            isHidden: categoryGroupPlain.isHidden,
            assignedTotal: totalsByMonth(categories) { $0.assigned.mapValues(\.assignedThisMonth) },
            activityTotal: totalsByMonth(categories) { $0.activity.mapValues(\.total) },
            availableTotal: totalsByMonth(categories) { $0.available.mapValues(\.total) },
            categories: categories
        )
    }
    
    func map(categoryGroupKindPlain: CategoryGroupKindPlain) -> CategoryGroupKind {
        switch categoryGroupKindPlain {
        case .inflow: .inflow
        case .regular: .regular
        }
    }
    
    func map(
        categoriesPlain: [CategoryPlain],
        using transactionsByCategory: TransactionsByCategory,
        in budgetRange: ClosedRange<MonthYear>
    ) -> [CategoryRow] {
        categoriesPlain.map { categoryPlain in
            map(categoryPlain: categoryPlain, using: transactionsByCategory, in: budgetRange)
        }
    }
    
    func map(
        categoryPlain: CategoryPlain,
        using transactionsByCategory: TransactionsByCategory,
        in budgetRange: ClosedRange<MonthYear>
    ) -> CategoryRow {
        let transactions = transactionsByCategory[ID<TransactionCategory>(categoryPlain.id)] ?? []
        let activity = activity(from: transactions, in: budgetRange)

        return CategoryRow(
            id: ID<CategoryRow>(categoryPlain.id),
            name: categoryPlain.name,
            notes: categoryPlain.notes,
            isHidden: categoryPlain.isHidden,
            assigned: assigned(for: categoryPlain, using: activity, in: budgetRange),
            activity: activity,
            available: available(assigned: categoryPlain.assigned, using: activity, in: budgetRange)
        )
    }
    
    // MARK: Assigned

    func assigned(
        for category: CategoryPlain,
        using activity: [MonthYear : Activity],
        in budgetRange: ClosedRange<MonthYear>
    ) -> [MonthYear: Assigned] {
        var assigned: [MonthYear: Assigned] = [:]
        
        var runningAssigned: Decimal = 0
        var runningSpent: Decimal = 0
        var monthCount: Decimal = 0
        
        for monthYear in budgetRange {
            let previousMonth = monthYear.advanced(by: -1)
            let spentLastMonth = monthCount > 0 ? -(activity[previousMonth]?.total ?? 0) : 0
            
            // Averages cover budget start ..< monthYear
            assigned[monthYear] = Assigned(
                assignedThisMonth: category.assigned[monthYear] ?? 0,
                assignedLastMonth: category.assigned[previousMonth] ?? 0,
                spentLastMonth: spentLastMonth,
                averageAssigned: monthCount > 0 ? runningAssigned / monthCount : 0,
                averageSpent: monthCount > 0 ? runningSpent / monthCount : 0
            )
            
            // Add this month so the next month's averages include it
            runningAssigned += category.assigned[monthYear] ?? 0
            runningSpent += -(activity[monthYear]?.total ?? 0)
            monthCount += 1
        }
        return assigned
    }

    // MARK: Activity

    func activity(
        from transactions: [BudgetTransaction],
        in budgetRange: ClosedRange<MonthYear>
    ) -> [MonthYear: Activity] {
        let byMonth = Dictionary(grouping: transactions) { MonthYear(from: $0.date) }
        
        var activity: [MonthYear: Activity] = [:]
        
        for monthYear in budgetRange {
            let monthly = byMonth[monthYear] ?? []
            activity[monthYear] = Activity(total: monthly.netAmount, transactions: monthly)
        }
        return activity
    }

    // MARK: Available

    func available(
        assigned: [MonthYear: Decimal],
        using activity: [MonthYear: Activity],
        in budgetRange: ClosedRange<MonthYear>
    ) -> [MonthYear: Available] {
        var available: [MonthYear: Available] = [:]
        
        for monthYear in budgetRange {
            let previous = available[monthYear.advanced(by: -1)]?.total ?? 0.00
            let cashFromLastMonth = max(previous, 0.00)
            let assignedThisMonth = assigned[monthYear] ?? 0.00
            let cashSpendingThisMonth = activity[monthYear]?.total ?? 0.00
            
            available[monthYear] = Available(
                total: cashFromLastMonth + assignedThisMonth + cashSpendingThisMonth,
                cashFromLastMonth: cashFromLastMonth,
                assignedThisMonth: assignedThisMonth,
                cashSpendingThisMonth: cashSpendingThisMonth,
                message: ""
            )
        }
        return available
    }
    
    // MARK: - Budget Settings
    
    func map(budgetSettingsPlain: BudgetSettingsPlain) -> BudgetSettings {
        return BudgetSettings(
            name: budgetSettingsPlain.name,
            curreny: budgetSettingsPlain.curreny,
            currencyFormet: budgetSettingsPlain.currencyFormet,
            numberFormat: budgetSettingsPlain.numberFormat,
            dateFormat: budgetSettingsPlain.dateFormat
        )
    }
    
    // MARK: - Totals by Month
    
    func totalsByMonth<Row>(
        _ rows: [Row],
        _ amountByMonth: (Row) -> [MonthYear: Decimal]
    ) -> [MonthYear: Decimal] {
        rows.reduce(into: [:]) { totals, row in
            totals.merge(amountByMonth(row), uniquingKeysWith: +)
        }
    }

    // MARK: - Budget Range

    func budgetRange(
        fromCategoryGroups categoryGroupsPlain: [CategoryGroupPlain],
        creditCardPaymentGroup: CreditCardPaymentGroupPlain,
        and transactions: [BudgetTransaction]
    ) -> ClosedRange<MonthYear> {
        let currentMonth = MonthYear.currentMonthYear
        let fallbackStart = currentMonth.advanced(by: -12)
        
        let assignedCategoryMonths = categoryGroupsPlain
            .flatMap(\.categories)
            .flatMap(\.assigned.keys)
        
        let assignedCardPaymentMonths = creditCardPaymentGroup.cardPayments
            .flatMap(\.assigned.keys)
        
        let assignedMonths = assignedCategoryMonths + assignedCardPaymentMonths

        let earliestActivityMonth = transactions
            .map { MonthYear(from: $0.date) }
            .min() ?? fallbackStart
        
        let earliestAssignedMonth = assignedMonths.min() ?? fallbackStart
        let latestAssignedMonth = assignedMonths.max() ?? currentMonth
        
        let start = min(earliestActivityMonth, earliestAssignedMonth)
        let end = max(latestAssignedMonth, currentMonth).advanced(by: 1)
        
        return start...end
    }
}

extension [BudgetTransaction] {
    var netAmount: Decimal { reduce(0) { $0 + $1.amount.signedValue } }
}
