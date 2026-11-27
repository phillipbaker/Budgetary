//
//  BudgetRowMapperTests.swift
//  Budgetary
//
//  Created by Phillip Baker on 24/11/2026.
//

import Foundation
import Testing
@testable import Budgetary

@Suite("BudgetRowMapper")
struct BudgetRowMapperTests {

    @Suite("Budget Data")
    struct BudgetDataTests {
        let mapper = BudgetRowMapper()

        let october = MonthYear(month: 10, year: 2026)
        let november = MonthYear(month: 11, year: 2026)

        @Test("Card funding uses category available and the card's starting balance")
        func cardActivityUsesCategoryAvailableAndStartingBalance() throws {
            let cardID = ID<BudgetAccountPlain>()
            let checkingID = ID<BudgetAccountPlain>()

            let shop = Plain.payee("Shop", type: .regular)
            let toChecking = Plain.payee("Checking", type: .transfer(checkingID))
            let toCard = Plain.payee("Credit Card", type: .transfer(cardID))

            // £150 assigned in October and not spent, so it rolls over into November.
            // Funding from November's assigned amount alone would fund nothing.
            let groceries = Plain.category("Groceries", assigned: [october: 150])
            let kidsClothes = Plain.category("Kids Clothes")

            // The card owed £100 when it was added. The £100 payment only covers
            // November's charge, so the refund can only pay down the starting balance.
            let card = Plain.account(cardID, "Credit Card", type: .creditCard, startingBalance: -100, transactions: [
                Plain.transaction(.outflow(100), payee: shop, category: groceries, in: november),
                Plain.transaction(.inflow(40), payee: shop, category: kidsClothes, in: november),
                Plain.transaction(.inflow(100), payee: toChecking, in: november)
            ])
            let checking = Plain.account(checkingID, "Checking", type: .checking, transactions: [
                Plain.transaction(.outflow(100), payee: toCard, in: november)
            ])

            let data = Plain.budgetData(
                payees: [shop, toChecking, toCard],
                accounts: [card, checking],
                categoryGroups: [Plain.categoryGroup("Spending", categories: [groceries, kidsClothes])],
                cardPayments: [Plain.cardPayment("Credit Card", accountID: cardID)]
            )

            let budget = mapper.mapBudgetData(from: data)
            let activity = try #require(budget.creditCardPaymentGroup.creditCardPayments.first?.activity[november])

            #expect(activity.fundedSpending == 100)
            #expect(activity.returnsApplied == 40)
            #expect(activity.payments == 100)
            #expect(activity.paymentsAndReturns == 140)
            #expect(activity.totalActivity == -40)
        }
    }

    @Suite("Ready to Assign")
    struct ReadyToAssignTests {
        let mapper = BudgetRowMapper()

        let november = MonthYear(month: 11, year: 2026)
        let december = MonthYear(month: 12, year: 2026)

        @Test("Money assigned to a card is taken from Ready to Assign")
        func cardAssignmentReducesReadyToAssign() throws {
            let budget = budget(cardAssigned: [november: 50])
            let readyToAssign = try #require(budget.readyToAssign[november])

            #expect(readyToAssign.assignedThisMonth == 50)
            #expect(readyToAssign.readyToAssignThisMonth == 150)
        }

        @Test("Category and card assignments are both taken from Ready to Assign")
        func categoryAndCardAssignmentsReduceReadyToAssign() throws {
            let budget = budget(categoryAssigned: [november: 30], cardAssigned: [november: 50])
            let readyToAssign = try #require(budget.readyToAssign[november])

            #expect(readyToAssign.assignedThisMonth == 80)
            #expect(readyToAssign.readyToAssignThisMonth == 120)
        }

        @Test("Money assigned to a card in a later month is held back now")
        func futureCardAssignmentIsHeldBack() throws {
            let budget = budget(cardAssigned: [december: 50])
            let thisMonth = try #require(budget.readyToAssign[november])
            let nextMonth = try #require(budget.readyToAssign[december])

            #expect(thisMonth.assignedInFuture == 50)
            #expect(thisMonth.readyToAssignThisMonth == 150)
            #expect(nextMonth.assignedThisMonth == 50)
            #expect(nextMonth.readyToAssignThisMonth == 150)
        }

        // MARK: - Overspending

        // November's overspending is taken from December's Ready to Assign. December starts
        // with November's £200 of income, less what was assigned in November.

        @Test("Overspending on a card isn't taken from Ready to Assign")
        func creditOverspendingIsNotTaken() throws {
            let budget = budget(spending: [.card(150, .groceries)])
            let nextMonth = try #require(budget.readyToAssign[december])

            #expect(nextMonth.cashOverspendingLastMonth == 0)
            #expect(nextMonth.readyToAssignThisMonth == 200)
        }

        @Test("Overspending in cash is taken from next month's Ready to Assign")
        func cashOverspendingIsTaken() throws {
            let budget = budget(categoryAssigned: [november: 50], spending: [.cash(80, .groceries)])
            let nextMonth = try #require(budget.readyToAssign[december])

            #expect(nextMonth.cashOverspendingLastMonth == 30)
            #expect(nextMonth.readyToAssignThisMonth == 120)
        }

        @Test("Only the cash part of mixed overspending is taken from Ready to Assign")
        func onlyCashPartOfMixedOverspendingIsTaken() throws {
            // £50 assigned, £70 in cash and £30 on the card: £20 cash and £30 credit overspending
            let budget = budget(categoryAssigned: [november: 50], spending: [.cash(70, .groceries), .card(30, .groceries)])
            let nextMonth = try #require(budget.readyToAssign[december])

            #expect(nextMonth.cashOverspendingLastMonth == 20)
            #expect(nextMonth.readyToAssignThisMonth == 130)
        }

        @Test("Card spending covered by cash left over isn't taken from Ready to Assign")
        func cardSpendingCoveredFirstByCashIsNotTaken() throws {
            // £100 assigned, £70 in cash and £50 on the card: only £20 of credit overspending
            let budget = budget(categoryAssigned: [november: 100], spending: [.cash(70, .groceries), .card(50, .groceries)])
            let nextMonth = try #require(budget.readyToAssign[december])

            #expect(nextMonth.cashOverspendingLastMonth == 0)
            #expect(nextMonth.readyToAssignThisMonth == 100)
        }

        @Test("Uncategorized card spending isn't taken from Ready to Assign")
        func uncategorizedCardSpendingIsNotTaken() throws {
            let budget = budget(spending: [.card(40, nil)])
            let nextMonth = try #require(budget.readyToAssign[december])

            #expect(nextMonth.cashOverspendingLastMonth == 0)
            #expect(nextMonth.readyToAssignThisMonth == 200)
        }

        @Test("Uncategorized cash spending is taken from next month's Ready to Assign")
        func uncategorizedCashSpendingIsTaken() throws {
            let budget = budget(spending: [.cash(40, nil)])
            let nextMonth = try #require(budget.readyToAssign[december])

            #expect(nextMonth.cashOverspendingLastMonth == 40)
            #expect(nextMonth.readyToAssignThisMonth == 160)
        }

        // MARK: - Helpers

        enum SpendingCategory {
            case groceries
        }

        /// A November purchase, in cash or on the card, with a category or uncategorized.
        enum Spending {
            case cash(Decimal, SpendingCategory?)
            case card(Decimal, SpendingCategory?)
        }

        /// A budget with £200 of income in November, one spending category and one card.
        func budget(
            categoryAssigned: [MonthYear: Decimal] = [:],
            cardAssigned: [MonthYear: Decimal] = [:],
            spending: [Spending] = []
        ) -> BudgetData {
            let cardID = ID<BudgetAccountPlain>()
            let checkingID = ID<BudgetAccountPlain>()

            let employer = Plain.payee("Employer", type: .regular)
            let shop = Plain.payee("Shop", type: .regular)
            let readyToAssign = Plain.category("Ready to Assign")
            let groceries = Plain.category("Groceries", assigned: categoryAssigned)

            func purchase(_ amount: Decimal, _ category: SpendingCategory?) -> TransactionPlain {
                Plain.transaction(.outflow(amount), payee: shop, category: category.map { _ in groceries }, in: november)
            }

            var cashTransactions = [Plain.transaction(.inflow(200), payee: employer, category: readyToAssign, in: november)]
            var cardTransactions: [TransactionPlain] = []

            for purchaseSpending in spending {
                switch purchaseSpending {
                case let .cash(amount, category): cashTransactions.append(purchase(amount, category))
                case let .card(amount, category): cardTransactions.append(purchase(amount, category))
                }
            }

            let checking = Plain.account(checkingID, "Checking", type: .checking, transactions: cashTransactions)
            let card = Plain.account(cardID, "Credit Card", type: .creditCard, transactions: cardTransactions)

            let data = Plain.budgetData(
                payees: [employer, shop],
                accounts: [checking, card],
                categoryGroups: [
                    Plain.categoryGroup("Inflow", kind: .inflow, categories: [readyToAssign]),
                    Plain.categoryGroup("Spending", categories: [groceries])
                ],
                cardPayments: [Plain.cardPayment("Credit Card", accountID: cardID, assigned: cardAssigned)]
            )

            return mapper.mapBudgetData(from: data)
        }
    }

    @Suite("Credit Cards")
    struct CreditCardPaymentRowTests {
        let mapper = BudgetRowMapper()

        let card = TransactionAccount(id: ID<TransactionAccount>(), name: "Credit Card")
        let checking = TransactionAccount(id: ID<TransactionAccount>(), name: "Checking")

        let kidsClothes = TransactionCategory(id: ID<TransactionCategory>(), name: "Kids Clothes")
        let gifts = TransactionCategory(id: ID<TransactionCategory>(), name: "Gifts")
        let groceries = TransactionCategory(id: ID<TransactionCategory>(), name: "Groceries")

        let october = MonthYear(month: 10, year: 2026)
        let november = MonthYear(month: 11, year: 2026)

        func cardPayment(assigned: [MonthYear: Decimal] = [:]) -> CreditCardPaymentPlain {
            CreditCardPaymentPlain(
                id: ID<CreditCardPaymentPlain>(),
                name: card.name,
                isHidden: false,
                assigned: assigned,
                accountID: card.id.rawValue
            )
        }

        // MARK: - Funding from category available

        @Test("Spending is funded up to what was assigned")
        func fundsSpendingCoveredByAssignment() {
            let activity = activity(
                [charge(100, groceries, in: november)],
                budget: [groceries: [november: .init(assigned: 150)]]
            )

            #expect(activity[november]?.fundedSpending == 100)
        }

        @Test("Spending beyond what was assigned is unfunded")
        func fundsOnlyWhatWasAssigned() {
            let activity = activity(
                [charge(100, groceries, in: november)],
                budget: [groceries: [november: .init(assigned: 80)]]
            )

            #expect(activity[november]?.fundedSpending == 80)
        }

        @Test("Money rolled over from earlier months funds spending")
        func fundsSpendingFromRolledOverMoney() {
            let activity = activity(
                [charge(50, groceries, in: november)],
                budget: [groceries: [november: .init(rolledOver: 100)]]
            )

            #expect(activity[november]?.fundedSpending == 50)
        }

        @Test("Cash spending is funded before card spending")
        func fundsCashSpendingFirst() {
            let activity = activity(
                [charge(50, groceries, in: november)],
                budget: [groceries: [november: .init(assigned: 100, cashSpending: 70)]]
            )

            #expect(activity[november]?.fundedSpending == 30)
        }

        @Test("Spending on other accounts isn't card spending, but is funded first")
        func ignoresSpendingOnOtherAccounts() {
            let activity = activity(
                [charge(50, groceries, in: november), charge(70, groceries, in: november, on: checking)],
                budget: [groceries: [november: .init(assigned: 100)]]
            )

            #expect(activity[november]?.spending == 50)
            #expect(activity[november]?.transactions.count == 1)
            #expect(activity[november]?.fundedSpending == 30)
        }

        @Test("Spending with nothing assigned is unfunded")
        func doesNotFundUnassignedSpending() {
            let activity = activity([charge(150, kidsClothes, in: october)])

            #expect(activity[october]?.fundedSpending == 0)
            #expect(activity[october]?.totalActivity == 0)
        }

        @Test("Uncategorized spending is unfunded")
        func doesNotFundUncategorizedSpending() {
            let activity = activity([charge(50, nil, in: november)])

            #expect(activity[november]?.fundedSpending == 0)
        }

        // MARK: - Charges and refunds in the same month

        @Test("A refund offsets a funded charge in the same month")
        func refundOffsetsFundedChargeInSameMonth() {
            let activity = activity(
                [charge(80, groceries, in: november), refund(30, groceries, in: november)],
                budget: [groceries: [november: .init(assigned: 100)]]
            )

            #expect(activity[november]?.fundedSpending == 50)
            #expect(activity[november]?.returnsApplied == 0)
        }

        @Test("A refund offsets an unfunded charge in the same month")
        func refundOffsetsUnfundedChargeInSameMonth() {
            let activity = activity([charge(120, groceries, in: november), refund(100, groceries, in: november)])

            #expect(activity[november]?.fundedSpending == 0)
            #expect(activity[november]?.returnsApplied == 0)
        }

        @Test("Net spending after a refund is funded up to what was assigned")
        func fundsNetSpendingAfterRefund() {
            let activity = activity(
                [charge(120, groceries, in: november), refund(100, groceries, in: november)],
                budget: [groceries: [november: .init(assigned: 50)]]
            )

            #expect(activity[november]?.fundedSpending == 20)
        }

        @Test("Net spending after a refund is partly funded")
        func partlyFundsNetSpendingAfterRefund() {
            let activity = activity(
                [charge(100, groceries, in: november), refund(20, groceries, in: november)],
                budget: [groceries: [november: .init(assigned: 30)]]
            )

            #expect(activity[november]?.fundedSpending == 30)
        }

        @Test("A net refund is not negative funded spending")
        func netRefundIsNotNegativeFundedSpending() {
            let activity = activity(
                [charge(20, groceries, in: november), refund(60, groceries, in: november)],
                budget: [groceries: [november: .init(assigned: 50)]]
            )

            #expect(activity[november]?.fundedSpending == 0)
        }

        // MARK: - Refunds that pay down the card

        @Test("A refund with nothing owed on the card does not pay it down")
        func refundWithNoDebtIsNotApplied() {
            let activity = activity([refund(40, kidsClothes, in: november)])

            #expect(activity[november]?.returnsApplied == 0)
            #expect(activity[november]?.paymentsAndReturns == 0)
        }

        @Test("A refund in a later month pays down unfunded spending")
        func laterRefundPaysDownUnfundedSpending() {
            let activity = activity([charge(100, kidsClothes, in: october), refund(40, kidsClothes, in: november)])

            #expect(activity[november]?.fundedSpending == 0)
            #expect(activity[november]?.paymentsAndReturns == 40)
            #expect(activity[november]?.totalActivity == -40)
        }

        @Test("A refund larger than what's owed only pays down what's owed")
        func refundIsCappedByWhatIsOwed() {
            let activity = activity([charge(100, kidsClothes, in: october), refund(150, kidsClothes, in: november)])

            #expect(activity[november]?.returnsApplied == 100)
            #expect(activity[november]?.paymentsAndReturns == 100)
        }

        @Test("A refund pays down charges in other categories in the same month")
        func refundPaysDownSameMonthCharges() {
            let activity = activity([charge(35, gifts, in: november), refund(100, kidsClothes, in: november)])

            #expect(activity[november]?.fundedSpending == 0)
            #expect(activity[november]?.returnsApplied == 35)
            #expect(activity[november]?.paymentsAndReturns == 35)
        }

        @Test("A payment in the same month reduces what a refund can pay down")
        func paymentReducesWhatRefundCanPayDown() {
            let activity = activity([
                charge(100, kidsClothes, in: october),
                payment(50, in: november),
                refund(100, kidsClothes, in: november)
            ])

            #expect(activity[november]?.returnsApplied == 50)
            #expect(activity[november]?.paymentsAndReturns == 100)
        }

        @Test("A refund pays down a balance owed when the card was added")
        func refundPaysDownStartingBalance() {
            let activity = activity([refund(40, kidsClothes, in: november)], startingBalance: -100)

            #expect(activity[november]?.returnsApplied == 40)
        }

        @Test("A transfer out of the card adds to what a refund can pay down")
        func transferOutAddsToWhatRefundCanPayDown() {
            let activity = activity([transferOut(30, in: november), refund(100, kidsClothes, in: november)])

            #expect(activity[november]?.transfersOut == 30)
            #expect(activity[november]?.returnsApplied == 30)
            #expect(activity[november]?.paymentsAndReturns == 0)
        }

        @Test("An uncategorized refund doesn't pay down the card")
        func uncategorizedRefundIsNotApplied() {
            let activity = activity([charge(100, kidsClothes, in: october), refund(40, nil, in: november)])

            #expect(activity[november]?.returns == 40)
            #expect(activity[november]?.returnsApplied == 0)
        }

        @Test("An uncategorized refund reduces what other refunds can pay down")
        func uncategorizedRefundReducesWhatIsOwed() {
            let activity = activity([
                charge(100, kidsClothes, in: october),
                refund(40, nil, in: november),
                refund(100, kidsClothes, in: november)
            ])

            #expect(activity[november]?.returnsApplied == 60)
        }

        // MARK: - Payment category available

        @Test("Money assigned to the card adds to what's set aside")
        func cardAssignmentAddsToAvailable() {
            let activity = activity([charge(100, kidsClothes, in: october)])
            let available = available(using: activity, assigned: [november: 100])

            #expect(activity[november]?.fundedSpending == 0)
            #expect(available[october]?.total == 0)
            #expect(available[november]?.assignedThisMonth == 100)
            #expect(available[november]?.total == 100)
        }

        // Current behaviour. A negative balance should probably be taken from
        // Ready to Assign the next month instead.
        @Test("A negative balance doesn't carry into the next month")
        func negativeAvailableDoesNotCarryForward() {
            let activity = activity([payment(50, in: october)])
            let available = available(using: activity)

            #expect(available[october]?.total == -50)
            #expect(available[november]?.cashFromLastMonth == 0)
            #expect(available[november]?.total == 0)
        }

        @Test("A refund of funded spending and a payment reduce what's set aside")
        func refundAndPaymentReduceFundedSetAside() {
            let activity = activity(
                [
                    charge(100, kidsClothes, in: october),
                    refund(40, kidsClothes, in: november),
                    payment(50, in: november)
                ],
                budget: [kidsClothes: [october: .init(assigned: 100)]]
            )
            let available = available(using: activity)

            #expect(activity[october]?.fundedSpending == 100)
            #expect(available[october]?.total == 100)
            #expect(activity[november]?.paymentsAndReturns == 90)
            #expect(activity[november]?.totalActivity == -90)
            #expect(available[november]?.total == 10)
        }

        @Test("A charge and refund in the same month are funded net of each other")
        func fundsChargeNetOfSameMonthRefund() {
            let activity = activity(
                [charge(100, kidsClothes, in: october), refund(40, kidsClothes, in: october)],
                budget: [kidsClothes: [october: .init(assigned: 100)]]
            )
            let available = available(using: activity)

            #expect(activity[october]?.fundedSpending == 60)
            #expect(activity[october]?.totalActivity == 60)
            #expect(available[october]?.total == 60)
        }

        @Test("Refunds with nothing owed leave the payment category alone")
        func refundsWithNoDebtLeavePaymentCategoryAlone() {
            let activity = activity([
                charge(35, gifts, in: november),
                refund(35, gifts, in: november),
                refund(100, kidsClothes, in: november),
                payment(50, in: november)
            ])
            let available = available(using: activity)

            #expect(activity[november]?.spending == 35)
            #expect(activity[november]?.returns == 135)
            #expect(activity[november]?.fundedSpending == 0)
            #expect(activity[november]?.paymentsAndReturns == 50)
            #expect(activity[november]?.totalActivity == -50)
            #expect(available[november]?.total == -50)
        }

        @Test("Refunds pay down unfunded spending from an earlier month")
        func refundsPayDownEarlierUnfundedSpending() {
            let activity = activity([
                charge(150, kidsClothes, in: october),
                charge(35, gifts, in: november),
                refund(35, gifts, in: november),
                refund(100, kidsClothes, in: november),
                payment(50, in: november)
            ])
            let available = available(using: activity)

            #expect(activity[october]?.fundedSpending == 0)
            #expect(activity[november]?.fundedSpending == 0)
            #expect(activity[november]?.paymentsAndReturns == 150)
            #expect(activity[november]?.totalActivity == -150)
            #expect(available[november]?.total == -150)
        }

        // MARK: - Helpers

        /// A category's budget for one month, apart from its card transactions.
        struct CategoryBudget {
            var rolledOver: Decimal = 0
            var assigned: Decimal = 0
            var cashSpending: Decimal = 0
        }

        /// Runs the card activity calculation on `transactions`.
        ///
        /// Each category's available is worked out the way the mapper passes it in: its
        /// `budget` for the month, plus that month's card transactions in the category.
        /// A category with no `budget` entry starts each month from £0, so overspending
        /// in one month doesn't roll over into the next.
        func activity(
            _ transactions: [BudgetTransaction],
            startingBalance: Decimal = 0,
            budget: [TransactionCategory: [MonthYear: CategoryBudget]] = [:]
        ) -> [MonthYear: CreditCardActivity] {
            let categories = Set(transactions.compactMap(\.category)).union(budget.keys)
            let months = october...november

            let availableByCategory = Dictionary(uniqueKeysWithValues: categories.map { category in
                let availableByMonth = Dictionary(uniqueKeysWithValues: months.map { monthYear in
                    let monthBudget = budget[category]?[monthYear] ?? CategoryBudget()
                    let cardActivity = transactions
                        .filter { $0.category == category && MonthYear(from: $0.date) == monthYear }
                        .netAmount
                    let available = monthBudget.rolledOver + monthBudget.assigned - monthBudget.cashSpending + cardActivity
                    return (monthYear, available)
                })
                return (category.id, availableByMonth)
            })

            return mapper.activity(
                for: cardPayment(),
                using: transactions,
                startingBalance: startingBalance,
                availableByCategory: availableByCategory,
                in: months
            )
        }

        /// The card's payment category available, with `assigned` money assigned directly to it.
        func available(
            using activity: [MonthYear: CreditCardActivity],
            assigned: [MonthYear: Decimal] = [:]
        ) -> [MonthYear: CreditCardAvailable] {
            mapper.available(for: cardPayment(assigned: assigned), using: activity, in: october...november)
        }

        /// A charge on the card, or on `account` when given.
        func charge(
            _ amount: Decimal,
            _ category: TransactionCategory?,
            in monthYear: MonthYear,
            on account: TransactionAccount? = nil
        ) -> BudgetTransaction {
            transaction(.outflow(amount), payee: .regular(name: "Shop"), category: category, in: monthYear, on: account ?? card)
        }

        func refund(_ amount: Decimal, _ category: TransactionCategory?, in monthYear: MonthYear) -> BudgetTransaction {
            transaction(.inflow(amount), payee: .regular(name: "Shop"), category: category, in: monthYear)
        }

        /// A payment from checking to the card.
        func payment(_ amount: Decimal, in monthYear: MonthYear) -> BudgetTransaction {
            transaction(.inflow(amount), payee: checkingPayee, category: nil, in: monthYear)
        }

        /// A transfer from the card to checking, such as a cash advance.
        func transferOut(_ amount: Decimal, in monthYear: MonthYear) -> BudgetTransaction {
            transaction(.outflow(amount), payee: checkingPayee, category: nil, in: monthYear)
        }

        var checkingPayee: Payee {
            .transfer(name: checking.name, accountID: ID<BudgetAccount>(checking.id))
        }

        func transaction(
            _ amount: Amount,
            payee: Payee,
            category: TransactionCategory?,
            in monthYear: MonthYear,
            on account: TransactionAccount? = nil
        ) -> BudgetTransaction {
            BudgetTransaction(
                id: ID<BudgetTransaction>(),
                date: Calendar.current.date(from: DateComponents(year: monthYear.year, month: monthYear.month, day: 15))!,
                memo: "",
                amount: amount,
                isCleared: false,
                payee: payee,
                category: category,
                account: account ?? card,
                linkedTransactionID: nil
            )
        }
    }
}

/// Builds the plain models `mapBudgetData(from:)` takes, for tests that run a whole budget.
private enum Plain {
    static func budgetData(
        payees: [PayeePlain],
        accounts: [BudgetAccountPlain],
        categoryGroups: [CategoryGroupPlain],
        cardPayments: [CreditCardPaymentPlain]
    ) -> BudgetDataPlain {
        BudgetDataPlain(
            budgetPlain: BudgetPlain(
                id: ID<BudgetPlain>(),
                settings: BudgetSettingsPlain(name: "Budget", curreny: "GBP", currencyFormet: "", numberFormat: "", dateFormat: ""),
                budgetAccountIDs: accounts.map(\.id),
                categoryGroupIDs: categoryGroups.map(\.id)
            ),
            payeesPlain: payees,
            budgetAccountsPlain: accounts,
            categoryGroupsPlain: categoryGroups,
            creditCardPaymentGroupPlain: CreditCardPaymentGroupPlain(
                id: ID<CreditCardPaymentGroupPlain>(),
                name: "Credit Card Payments",
                cardPayments: cardPayments
            )
        )
    }

    static func payee(_ name: String, type: PayeeTypePlain) -> PayeePlain {
        PayeePlain(
            id: ID<PayeePlain>(),
            name: name,
            type: type,
            aliases: [],
            includedInPayeeList: true,
            automaticallyCategorizeIsOn: false,
            defaultCategoryID: nil
        )
    }

    static func categoryGroup(
        _ name: String,
        kind: CategoryGroupKindPlain = .regular,
        categories: [CategoryPlain]
    ) -> CategoryGroupPlain {
        CategoryGroupPlain(id: ID<CategoryGroupPlain>(), name: name, kind: kind, isHidden: false, categories: categories)
    }

    static func category(_ name: String, assigned: [MonthYear: Decimal] = [:]) -> CategoryPlain {
        CategoryPlain(id: ID<CategoryPlain>(), name: name, notes: "", isHidden: false, assigned: assigned)
    }

    static func cardPayment(
        _ name: String,
        accountID: ID<BudgetAccountPlain>,
        assigned: [MonthYear: Decimal] = [:]
    ) -> CreditCardPaymentPlain {
        CreditCardPaymentPlain(id: ID<CreditCardPaymentPlain>(), name: name, isHidden: false, assigned: assigned, accountID: accountID.rawValue)
    }

    static func account(
        _ id: ID<BudgetAccountPlain>,
        _ name: String,
        type: BudgetAccountTypePlain,
        startingBalance: Decimal = 0,
        transactions: [TransactionPlain]
    ) -> BudgetAccountPlain {
        BudgetAccountPlain(
            id: id,
            name: name,
            accountType: type,
            startingBalance: startingBalance,
            notes: nil,
            isClosed: false,
            transactions: transactions
        )
    }

    /// A transaction on the 15th of `monthYear`.
    static func transaction(
        _ amount: Amount,
        payee: PayeePlain,
        category: CategoryPlain? = nil,
        in monthYear: MonthYear
    ) -> TransactionPlain {
        TransactionPlain(
            id: ID<TransactionPlain>(),
            date: Calendar.current.date(from: DateComponents(year: monthYear.year, month: monthYear.month, day: 15))!,
            memo: "",
            amount: amount,
            isCleared: false,
            payeeID: payee.id,
            categoryID: category?.id,
            linkedTransactionID: nil
        )
    }
}
