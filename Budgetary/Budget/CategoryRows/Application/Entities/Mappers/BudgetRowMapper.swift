//
//  BudgetRowMapper.swift
//  Budgetary
//
//  Created by Phillip Baker on 25/10/2024.
//

import Foundation

public final class BudgetRowMapper: Sendable {
    typealias AvailableByCategory = [ID<TransactionCategory>: [MonthYear: Decimal]]
    typealias TransactionsByCategory = [ID<TransactionCategory>: [BudgetTransaction]]
    
    // MARK: - Budget Data
    
    func mapBudgetData(from data: BudgetDataPlain) -> BudgetData {
        
        // MARK: Transactions
        
        let transactions = data.budgetAccountsPlain.flatMap { account in
            TransactionMapper.mapTransactions(for: account, fromPayees: data.payeesPlain, andCategoryGroups: data.categoryGroupsPlain)
        }
        
        // MARK: Budget Range
        
        let budgetRange = budgetRange(
            fromCategoryGroups: data.categoryGroupsPlain,
            creditCardPaymentGroup: data.creditCardPaymentGroupPlain,
            and: transactions
        )
        
        // MARK: Credit Card Account IDs
        
        let creditCardAccountIDs = Set(
            data.budgetAccountsPlain
                .filter { $0.accountType == .creditCard }
                .map { ID<TransactionAccount>($0.id) }
        )

        // MARK: Category Group Rows

        let transactionsByCategory = Dictionary(
            grouping: transactions.filteredBySpending.filter { $0.category != nil },
            by: { $0.category!.id }
        )

        let categoryGroupRows = map(
            categoryGroupsPlain: data.categoryGroupsPlain,
            using: transactionsByCategory,
            creditCardAccountIDs: creditCardAccountIDs,
            in: budgetRange
        )
        
        // MARK: Available By Category

        let availableByCategory: AvailableByCategory = Dictionary(
            categoryGroupRows
                .flatMap(\.categories)
                .map { (ID<TransactionCategory>($0.id), $0.available.mapValues(\.total)) }, uniquingKeysWith: { first, _ in first }
        )

        // MARK: Uncategorized Row
        
        let uncategorizedTransactions = transactions
            .filter { $0.category == nil }
            .filteredBySpending // exclude transfers
        
        let uncategorizedActivity = activity(
            from: uncategorizedTransactions,
            creditCardAccountIDs: creditCardAccountIDs,
            in: budgetRange
        )

        let uncategorizedRow = CategoryRow(
            id: .uncategorized,
            name: "Uncategorized Transactions",
            notes: "",
            isHidden: false,
            assigned: [:],
            activity: uncategorizedActivity,
            available: available(assigned: [:], using: uncategorizedActivity, in: budgetRange)
        )
        
        // MARK: Ready to Assign
        
        let startingBalanceByAccount: [UUID: Decimal] = Dictionary(
            data.budgetAccountsPlain.map { ($0.id.rawValue, $0.startingBalance) },
            uniquingKeysWith: { first, _ in first }
        )

        let creditCardPaymentRows = map(
            paymentsPlain: data.creditCardPaymentGroupPlain.cardPayments,
            using: transactions,
            startingBalanceByAccount: startingBalanceByAccount,
            availableByCategory: availableByCategory,
            in: budgetRange
        )

        let readyToAssignID = data.categoryGroupsPlain.readyToAssignCategoryID
            .map { ID<TransactionCategory>($0) }

        let inflows = activity(
            from: readyToAssignID.flatMap { transactionsByCategory[$0] } ?? [],
            creditCardAccountIDs: creditCardAccountIDs,
            in: budgetRange
        ).mapValues(\.total)
        
        let creditCardOverpaymentsByMonth = totalsByMonth(creditCardPaymentRows) { $0.activity.mapValues(\.overpayment) }
        
        let inflowsByMonth = inflows.merging(creditCardOverpaymentsByMonth, uniquingKeysWith: +)
        
        let spendingRows = [uncategorizedRow] + categoryGroupRows
            .filter { $0.kind != .inflow }
            .flatMap(\.categories)
        
        let assignedByMonth = totalsByMonth(spendingRows) { $0.assigned.mapValues(\.assignedThisMonth) }
            .merging(totalsByMonth(creditCardPaymentRows) { $0.assigned.mapValues(\.assignedThisMonth) }, uniquingKeysWith: +)
        
        let cashOverspendingByMonth = totalsByMonth(spendingRows) { $0.available.mapValues(\.cashOverspending) }
            .merging(totalsByMonth(creditCardPaymentRows) { $0.available.mapValues(\.cashOverspending) }, uniquingKeysWith: +)
        
        let readyToAssign = readyToAssign(
            inflowsByMonth: inflowsByMonth,
            assignedByMonth: assignedByMonth,
            cashOverspendingByMonth: cashOverspendingByMonth,
            in: budgetRange
        )
        
        // MARK: Credit Card Payment Group
        
        let creditCardPaymentGroup = creditCardPaymentGroup(
            id: data.creditCardPaymentGroupPlain.id,
            name: data.creditCardPaymentGroupPlain.name,
            creditCardPaymentRows: creditCardPaymentRows
        )
        
        // MARK: Settings

        let settings = map(budgetSettingsPlain: data.budgetPlain.settings)

        return BudgetData(
            id: ID<BudgetData>(data.budgetPlain.id),
            readyToAssign: readyToAssign,
            uncategorized: uncategorizedRow,
            categoryGroups: categoryGroupRows,
            creditCardPaymentGroup: creditCardPaymentGroup,
            settings: settings,
            range: budgetRange
        )
    }

    // MARK: - Ready To Assign

    func readyToAssign(
        inflowsByMonth: [MonthYear: Decimal],
        assignedByMonth: [MonthYear: Decimal],
        cashOverspendingByMonth: [MonthYear: Decimal],
        in budgetRange: ClosedRange<MonthYear>
    ) -> [MonthYear: ReadyToAssign] {
        var readyToAssign: [MonthYear: ReadyToAssign] = [:]
        
        for monthYear in budgetRange {
            // Inflows for monthYear
            var readyToAssignFromLastMonth: Decimal = 0.00
            
            if let lastMonth = readyToAssign[monthYear.advanced(by: -1)] {
                readyToAssignFromLastMonth = lastMonth.availableToAssignFromLastMonth + lastMonth.inflowThisMonth - lastMonth.assignedThisMonth - lastMonth.cashOverspendingLastMonth
            }
            
            let inflowThisMonth = inflowsByMonth[monthYear] ?? 0
            let totalInflowsThisMonth = readyToAssignFromLastMonth + inflowThisMonth
            
            // Outflows for monthYear
            let cashOverspendingLastMonth = cashOverspendingByMonth[monthYear.advanced(by: -1)] ?? 0
            let assignedThisMonth = assignedByMonth[monthYear] ?? 0
            let assignedInFuture: Decimal = {
                // Calculate inflow/outflow balance for current month excluding assignedInFuture
                let currentMonthReadyToAssignBalance = (readyToAssignFromLastMonth + inflowThisMonth) - (cashOverspendingLastMonth + assignedThisMonth)
                
                // If current month inflow/outflow is negative or zero in isolation, set assignedInFuture to 0 and ignore
                guard currentMonthReadyToAssignBalance > 0 else {
                    return 0.00
                }
                
                // If here, current month has positive inflow/outflow balance
                let assignedInFutureTotal = assignedByMonth
                    .filter { $0.key > monthYear }
                    .map(\.value)
                    .reduced
                
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
    
    func map(paymentsPlain: [CreditCardPaymentPlain], using transactions: [BudgetTransaction], startingBalanceByAccount: [UUID: Decimal], availableByCategory: AvailableByCategory, in budgetRange: ClosedRange<MonthYear>) -> [CreditCardPaymentRow] {
        paymentsPlain.map { cardPayment in
            map(paymentPlain: cardPayment, using: transactions, startingBalance: startingBalanceByAccount[cardPayment.accountID] ?? 0, availableByCategory: availableByCategory, in: budgetRange)
        }
    }

    func map(paymentPlain: CreditCardPaymentPlain, using transactions: [BudgetTransaction], startingBalance: Decimal, availableByCategory: AvailableByCategory, in budgetRange: ClosedRange<MonthYear>) -> CreditCardPaymentRow {
        let activity = activity(
            for: paymentPlain,
            using: transactions,
            startingBalance: startingBalance,
            availableByCategory: availableByCategory,
            in: budgetRange
        )
        
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
        startingBalance: Decimal,
        availableByCategory: AvailableByCategory,
        in budgetRange: ClosedRange<MonthYear>
    ) -> [MonthYear: CreditCardActivity] {
        
        let cardTransactions = transactions.filtered(byAccount: creditCardPaymentPlain.accountID)
        let byMonth = Dictionary(grouping: cardTransactions) { MonthYear(from: $0.date) }
        var activity: [MonthYear: CreditCardActivity] = [:]
        
        var balance = startingBalance  // negative while the card owes money
        
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
            
            var fundedSpending: Decimal = 0.00
            var netRefunds: Decimal = 0.00
            
            var netRefundCategoryIDs: Set<ID<TransactionCategory>> = []
            
            for (category, netSpending) in spendingByCategory {
                guard let categoryID = category?.id else { continue }
                guard netSpending > 0 else {
                    if netSpending < 0 {
                        netRefunds += -netSpending
                        netRefundCategoryIDs.insert(categoryID)
                    }
                    continue
                }
                
                // If no available value for a category, skip funding and count its spending as unfunded
                guard let available = availableByCategory[categoryID]?[monthYear] else {
                    assertionFailure("No available for \(categoryID) in \(monthYear)")
                    continue
                }
                
                // Fund from what the category had before this card's spending; cash spending is funded first.
                let availableBeforeCard = max(available + netSpending, 0)
                fundedSpending += min(availableBeforeCard, netSpending)
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
            
            var overpayment: Decimal = 0
            var debtPaidByRefunds: Decimal = 0
            
            for transaction in monthlyCardTransactions.sorted(by: cardOrder) {
                let before = balance
                balance += transaction.amount.signedValue

                if transaction.isPayment {
                    overpayment += max(balance, 0) - max(before, 0)       // how far above £0 it went
                } else if transaction.isRefund,
                          let categoryID = transaction.category?.id,
                          netRefundCategoryIDs.contains(categoryID) {
                    debtPaidByRefunds += min(balance, 0) - min(before, 0) // how much debt it cleared
                }
            }
            
            let returnsApplied = min(netRefunds, debtPaidByRefunds)
            
            activity[monthYear] = CreditCardActivity(
                spending: spending,
                returns: returns,
                returnsApplied: returnsApplied,
                fundedSpending: fundedSpending,
                payments: payments,
                overpayment: overpayment,
                transfersOut: transfersOut,
                transactions: monthlyCardTransactions
            )
        }
        
        return activity
    }
    
    /// Sorts a card's transactions by date. On the same day, charges and transfers out
    /// come first, then payments, then refunds.
    private func cardOrder(_ lhs: BudgetTransaction, _ rhs: BudgetTransaction) -> Bool {
        if lhs.date != rhs.date { return lhs.date < rhs.date }
        return sameDayRank(lhs) < sameDayRank(rhs)
    }
    
    private func sameDayRank(_ transaction: BudgetTransaction) -> Int {
        if transaction.isPayment { 1 }
        else if transaction.isRefund { 2 }
        else { 0 } // charges and transfers out
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
        creditCardAccountIDs: Set<ID<TransactionAccount>>,
        in budgetRange: ClosedRange<MonthYear>
    ) -> [CategoryGroupRow] {
        categoryGroupsPlain.map { categoryGroupPlain in
            map(
                categoryGroupPlain: categoryGroupPlain,
                using: transactionsByCategory,
                creditCardAccountIDs: creditCardAccountIDs,
                in: budgetRange
            )
        }
    }
    
    func map(
        categoryGroupPlain: CategoryGroupPlain,
        using transactionsByCategory: TransactionsByCategory,
        creditCardAccountIDs: Set<ID<TransactionAccount>>,
        in budgetRange: ClosedRange<MonthYear>
    ) -> CategoryGroupRow {
        let categories = map(
            categoriesPlain: categoryGroupPlain.categories,
            using: transactionsByCategory,
            creditCardAccountIDs: creditCardAccountIDs,
            in: budgetRange
        )
        
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
        creditCardAccountIDs: Set<ID<TransactionAccount>>,
        in budgetRange: ClosedRange<MonthYear>
    ) -> [CategoryRow] {
        categoriesPlain.map { categoryPlain in
            map(categoryPlain: categoryPlain, using: transactionsByCategory, creditCardAccountIDs: creditCardAccountIDs, in: budgetRange)
        }
    }
    
    func map(
        categoryPlain: CategoryPlain,
        using transactionsByCategory: TransactionsByCategory,
        creditCardAccountIDs: Set<ID<TransactionAccount>>,
        in budgetRange: ClosedRange<MonthYear>
    ) -> CategoryRow {
        let transactions = transactionsByCategory[ID<TransactionCategory>(categoryPlain.id)] ?? []
        let activity = activity(from: transactions, creditCardAccountIDs: creditCardAccountIDs, in: budgetRange)

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
        creditCardAccountIDs: Set<ID<TransactionAccount>>,
        in budgetRange: ClosedRange<MonthYear>
    ) -> [MonthYear: Activity] {
        let transactionsByMonth = Dictionary(grouping: transactions) { MonthYear(from: $0.date) }
        
        var activity: [MonthYear: Activity] = [:]
        
        for monthYear in budgetRange {
            activity[monthYear] = Activity(
                transactions: transactionsByMonth[monthYear] ?? [],
                creditCardAccountIDs: creditCardAccountIDs
            )
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
            
            available[monthYear] = Available(
                cashFromLastMonth: cashFromLastMonth,
                assignedThisMonth: assignedThisMonth,
                cashActivityThisMonth: activity[monthYear]?.cashTotal ?? 0.00,
                creditActivityThisMonth: activity[monthYear]?.creditTotal ?? 0.00,
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

extension ID where Value == CategoryRow {
    static let uncategorized = ID(UUID(uuidString: "00000000-0000-0000-0000-000000000001")!)
}
