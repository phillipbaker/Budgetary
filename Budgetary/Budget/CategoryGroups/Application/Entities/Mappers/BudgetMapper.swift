//
//  BudgetMapper.swift
//  Budgetary
//
//  Created by Phillip Baker on 25/10/2024.
//

import Foundation

public final class BudgetMapper: Sendable {
    // MARK: - Combined Budget Data to Budget
    
    func mapBudget(
        for monthYear: MonthYear,
        filteredBy filter: CategoryFilter,
        from data: CombinedBudgetData
    ) -> Budget {
        return Budget(
            id: data.budgetPlain.id,
            monthYear: monthYear,
            filter: filter,
            readyToAssign: mapReadyToAssign(from: data),
            categoryGroups: mapCategoryGroups(for: monthYear, filteredBy: filter, from: data),
            settings: mapBudgetSettings(plain: data.budgetPlain.settings),
            start: mapBudgetStart(from: data),
            end: mapBudgetEnd(from: data)
        )
    }
    
    // MARK: - Budget Settings Plain to Entity
    
    func mapBudgetSettings(plain: BudgetSettingsPlain) -> BudgetSettings {
        return BudgetSettings(
            name: plain.name,
            curreny: plain.curreny,
            currencyFormet: plain.currencyFormet,
            numberFormat: plain.numberFormat,
            dateFormat: plain.dateFormat
        )
    }
    
    // MARK: - Filtered CategoryGroups Plain to Entity
    
//    func mapCategoryGroups(
//        for monthYear: MonthYear,
//        filteredBy filter: CategoryFilter,
//        from data: CombinedBudgetData
//    ) -> [CategoryGroup] {
//        let categoryGroups = data.categoryGroupsPlain.map { categoryGroup in
//            map(categoryGroupPlain: categoryGroup, from: data)
//        }
//        
//        switch filter {
//        case .allCategories:
//            return categoryGroups
//        case .underfunded:
//            var groups: [CategoryGroup] = []
//            for group in categoryGroups {
//                let underfundedCategories = group.categories.filter { $0.available[monthYear]?.total ?? 0.00 < 0.00 }
//                groups.append(
//                    CategoryGroup(
//                        id: group.id,
//                        name: group.name,
//                        isHidden: group.isHidden,
//                        assignedTotal: mapGroupAssignedTotal(for: underfundedCategories),
//                        activityTotal: mapGroupActivityTotal(for: underfundedCategories),
//                        availableTotal: mapGroupAvailableTotal(for: underfundedCategories),
//                        categories: underfundedCategories
//                    )
//                )
//            }
//            return groups.filter { !$0.categories.isEmpty }
//        case .moneyAvailable:
//            var groups: [CategoryGroup] = []
//            for group in categoryGroups {
//                let moneyAvailableCategories = group.categories.filter { $0.available[monthYear]?.total ?? 0.00 > 0.00 }
//                groups.append(
//                    CategoryGroup(
//                        id: group.id,
//                        name: group.name,
//                        isHidden: group.isHidden,
//                        assignedTotal: mapGroupAssignedTotal(for: moneyAvailableCategories),
//                        activityTotal: mapGroupActivityTotal(for: moneyAvailableCategories),
//                        availableTotal: mapGroupAvailableTotal(for: moneyAvailableCategories),
//                        categories: moneyAvailableCategories
//                    )
//                )
//            }
//            return groups.filter { !$0.categories.isEmpty }
//        }
//    }
    
    // MARK: - Filtered CategoryGroups Plain to New Entity to Existing Entity
    
    func mapCategoryGroups(
        for monthYear: MonthYear,
        filteredBy filter: CategoryFilter,
        from data: CombinedBudgetData
    ) -> [CategoryGroup] {
//        let categoryGroups = data.categoryGroupsPlain.map { categoryGroup in
//            map(categoryGroupPlain: categoryGroup, from: data)
//        }
        
        let categoryGroupsEntities = map(categoryGroupsPlain: data.categoryGroupsPlain)
        let categoryGroups = categoryGroupsEntities.map { categoryGroupEntity in
                map(categoryGroupEntity: categoryGroupEntity, from: data)
        }
        
        switch filter {
        case .allCategories:
            return categoryGroups
        case .underfunded:
            var groups: [CategoryGroup] = []
            for group in categoryGroups {
                let underfundedCategories = group.categories.filter { $0.available[monthYear]?.total ?? 0.00 < 0.00 }
                groups.append(
                    CategoryGroup(
                        id: group.id,
                        name: group.name,
                        isHidden: group.isHidden,
                        assignedTotal: mapGroupAssignedTotal(for: underfundedCategories),
                        activityTotal: mapGroupActivityTotal(for: underfundedCategories),
                        availableTotal: mapGroupAvailableTotal(for: underfundedCategories),
                        categories: underfundedCategories
                    )
                )
            }
            return groups.filter { !$0.categories.isEmpty }
        case .moneyAvailable:
            var groups: [CategoryGroup] = []
            for group in categoryGroups {
                let moneyAvailableCategories = group.categories.filter { $0.available[monthYear]?.total ?? 0.00 > 0.00 }
                groups.append(
                    CategoryGroup(
                        id: group.id,
                        name: group.name,
                        isHidden: group.isHidden,
                        assignedTotal: mapGroupAssignedTotal(for: moneyAvailableCategories),
                        activityTotal: mapGroupActivityTotal(for: moneyAvailableCategories),
                        availableTotal: mapGroupAvailableTotal(for: moneyAvailableCategories),
                        categories: moneyAvailableCategories
                    )
                )
            }
            return groups.filter { !$0.categories.isEmpty }
        }
    }
    
    // MARK: Category Groups Plain to Existing Entities
    
    func map(categoryGroupPlain: CategoryGroupPlain, from data: CombinedBudgetData) -> CategoryGroup {
        let categories = map(categoriesPlain: categoryGroupPlain.categories, from: data)
        return CategoryGroup(
            id: categoryGroupPlain.id,
            name: categoryGroupPlain.name,
            isHidden: categoryGroupPlain.isHidden,
            assignedTotal: mapGroupAssignedTotal(for: categories),
            activityTotal: mapGroupActivityTotal(for: categories),
            availableTotal: mapGroupAvailableTotal(for: categories),
            categories: categories
        )
    }
    
    func map(categoriesPlain: [CategoryPlain], from data: CombinedBudgetData) -> [Category] {
        return categoriesPlain.map { categoryPlain in
            map(categoryPlain: categoryPlain, from: data)
        }
    }
    
    func map(categoryPlain: CategoryPlain, from data: CombinedBudgetData) -> Category {
        return Category(
            id: categoryPlain.id,
            name: categoryPlain.name,
            notes: categoryPlain.notes,
            isHidden: categoryPlain.isHidden,
            assigned: mapAssigned(for: categoryPlain, from: data),
            activity: mapActivity(for: categoryPlain, from: data),
            available: mapAvailable(for: categoryPlain, from: data)
        )
    }
    
    // MARK: New Category Entities to Existing Category Group Entity Models
    
    func map(categoryGroupEntity: CategoryGroupEntity, from data: CombinedBudgetData) -> CategoryGroup {
        let categories = map(categoryEntities: categoryGroupEntity.categories, from: data)
        return CategoryGroup(
            id: categoryGroupEntity.id,
            name: categoryGroupEntity.name,
            isHidden: categoryGroupEntity.isHidden,
            assignedTotal: mapGroupAssignedTotal(for: categories),
            activityTotal: mapGroupActivityTotal(for: categories),
            availableTotal: mapGroupAvailableTotal(for: categories),
            categories: categories
        )
    }
    
    func map(categoryEntities: [CategoryEntity], from data: CombinedBudgetData) -> [Category] {
        return categoryEntities.map { categoryEntity in
            map(categoryEntity: categoryEntity, from: data)
        }
    }
    
    func map(categoryEntity: CategoryEntity, from data: CombinedBudgetData) -> Category {
        return Category(
            id: categoryEntity.id,
            name: categoryEntity.name,
            notes: categoryEntity.notes,
            isHidden: categoryEntity.isHidden,
            assigned: mapAssigned(for: categoryEntity, from: data),
            activity: mapActivity(for: categoryEntity, from: data),
            available: mapAvailable(for: categoryEntity, from: data)
        )
    }
    
    func mapAssigned(for category: CategoryEntity, from data: CombinedBudgetData) -> [MonthYear: Assigned] {
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
    
    func activity(for category: CategoryEntity, in monthYear: MonthYear, from data: CombinedBudgetData) -> Decimal {
        return data.budgetAccountsPlain
            .flatMap { $0.transactions }
            .filter { MonthYear(from: $0.date) == monthYear }
            .filter { $0.categoryId == category.id }
            .compactMap { $0.amount.value }
            .reduce(0.00, +)
    }
    
    // TODO: This functionalit is duplicated on line 284-ish activity(for category:, in monthYear:, from: data) - fifure out how to consolidate for all of my uses in the simplest/most efficeint/DRY way...
    func mapActivity(for category: CategoryEntity, from data: CombinedBudgetData) -> [MonthYear: Activity] {
        var activity: [MonthYear: Activity] = [:]
        
        for monthYear in budgetRange(from: data) {
            let transactions = data.budgetAccountsPlain
                .flatMap { $0.transactions }
                .filter { MonthYear(from: $0.date) == monthYear }
                .filter { $0.categoryId == category.id }
            
            let total = transactions
                .compactMap { $0.amount.value }
                .reduce(0.00, +)
            
            activity[monthYear] = Activity(total: total, transactions: TransactionMapper.map(transactionsPlain: transactions, fromPayees: data.payeesPlain, andCategoryGroups: data.categoryGroupsPlain))
        }
        return activity
    }
    
    func mapAvailable(for category: CategoryEntity, from data: CombinedBudgetData) -> [MonthYear: Available] {
        
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
    
    
    
//    // MARK: Mapping Category Groups From Entity and Metadata models
//    
//    func mapCategoryGroups(from entities: [CategoryGroupEntity], and metadata: [CategoryGroupMetadata]) -> [CategoryGroup] {
//        
//    }
//    
//    func mapCategoryGroup(from entity: CategoryGroupEntity, and metadata: CategoryGroupMetadata) -> CategoryGroup {
//        guard entity.id == metadata.categoryGroupId else {
//            print("Entity and metadata ids did not match for \(entity.name)")
//            return CategoryGroup(id: "", name: "", isHidden: false, assignedTotal: [:], activityTotal: [:], availableTotal: [:], categories: [])
//        }
//        return CategoryGroup(
//            id: entity.id,
//            name: entity.name,
//            isHidden: entity.isHidden,
//            assignedTotal: mapGroupAssignedTotal(for: <#T##[Category]#>),
//            activityTotal: <#T##[MonthYear : Decimal]#>,
//            availableTotal: <#T##[MonthYear : Decimal]#>,
//            categories: <#T##[Category]#>
//        )
//    }
    
    // MARK: Plain to Category Entities
    
    func map(categoryGroupsPlain: [CategoryGroupPlain]) -> [CategoryGroupEntity] {
        categoryGroupsPlain.map { categoryGroupPlain in
            map(categoryGroupPlain: categoryGroupPlain)
        }
    }
    
    func map(categoryGroupPlain: CategoryGroupPlain) -> CategoryGroupEntity {
        return CategoryGroupEntity(
            id: categoryGroupPlain.id,
            name: categoryGroupPlain.name,
            isHidden: categoryGroupPlain.isHidden,
            assignedTotal: mapAssignedTotals(for: categoryGroupPlain),
            categories: map(categoriesPlain: categoryGroupPlain.categories)
        )
    }
    
    func mapAssignedTotals(for group: CategoryGroupPlain) -> [MonthYear : Decimal] {
        var totals: [MonthYear: Decimal] = [:]
        
        for category in group.categories {
            for (monthYear, assigned) in category.assigned {
                if let existingValue = totals[monthYear] {
                    totals[monthYear] = existingValue + assigned
                } else {
                    totals[monthYear] = assigned
                }
            }
        }
        return totals
        
    }
    
    func map(categoriesPlain: [CategoryPlain]) -> [CategoryEntity] {
        categoriesPlain.map { categoryPlain in
            map(categoryPlain: categoryPlain)
        }
    }
    
    func map(categoryPlain: CategoryPlain) -> CategoryEntity {
        return CategoryEntity(
            id: categoryPlain.id,
            name: categoryPlain.name,
            notes: categoryPlain.notes,
            isHidden: categoryPlain.isHidden,
            assigned: categoryPlain.assigned
        )
    }
    
//    // MARK: Category Metadata
//    
//    func mapMetadata(from data: CombinedBudgetData) -> [CategoryGroupMetadata] {
//        return data.categoryGroupsPlain.map { categoryGroup in
//            mapMetadata(for: categoryGroup, from: data)
//        }
//    }
//    
//    func mapMetadata(for categoryGroup: CategoryGroupPlain, from data: CombinedBudgetData) -> CategoryGroupMetadata {
//        let categories = map(categoriesPlain: categoryGroup.categories, from: data)
//        return CategoryGroupMetadata(
//            id: UUID().uuidString,
//            categoryGroupId: categoryGroup.id,
//            activityTotal: mapGroupActivityTotal(for: categories),
//            availableTotal: mapGroupAvailableTotal(for: categories),
//            categoryTotals: mapMetadata(for: categoryGroup.categories, from: data)
//        )
//    }
//    
//    func mapMetadata(for categories: [CategoryPlain], from data: CombinedBudgetData) -> [CategoryMetadata] {
//        categories.map { category in
//            mapMetadata(for: category, from: data)
//        }
//    }
//    
//    func mapMetadata(for categoryPlain: CategoryPlain, from data: CombinedBudgetData) -> CategoryMetadata {
//        return CategoryMetadata(
//            id: UUID().uuidString,
//            categoryId: categoryPlain.id,
//            activity: mapActivity(for: categoryPlain, from: data),
//            available: mapAvailable(for: categoryPlain, from: data)
//        )
//    }
    
    
    // MARK: Assigned
    
    func mapGroupAssignedTotal(for categories: [Category]) -> [MonthYear: Decimal] {
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
    
    func mapAssigned(for category: CategoryPlain, from data: CombinedBudgetData) -> [MonthYear: Assigned] {
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
    
    // MARK: Activity
    
    func mapGroupActivityTotal(for categories: [Category]) -> [MonthYear: Decimal] {
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
    
    // TODO: This functionalit is duplicated on line 284-ish activity(for category:, in monthYear:, from: data) - fifure out how to consolidate for all of my uses in the simplest/most efficeint/DRY way...
    func mapActivity(for category: CategoryPlain, from data: CombinedBudgetData) -> [MonthYear: Activity] {
        var activity: [MonthYear: Activity] = [:]
        
        for monthYear in budgetRange(from: data) {
            let transactions = data.budgetAccountsPlain
                .flatMap { $0.transactions }
                .filter { MonthYear(from: $0.date) == monthYear }
                .filter { $0.categoryId == category.id }
            
            let total = transactions
                .compactMap { $0.amount.value }
                .reduce(0.00, +)
            
            activity[monthYear] = Activity(total: total, transactions: TransactionMapper.map(transactionsPlain: transactions, fromPayees: data.payeesPlain, andCategoryGroups: data.categoryGroupsPlain))
        }
        return activity
    }
    
    // THIS ONE CORRECT
    func activity(for category: CategoryPlain, in monthYear: MonthYear, from data: CombinedBudgetData) -> Decimal {
        return data.budgetAccountsPlain
            .flatMap { $0.transactions }
            .filter { MonthYear(from: $0.date) == monthYear }
            .filter { $0.categoryId == category.id }
            .compactMap { $0.amount.value }
            .reduce(0.00, +)
    }
    
    // MARK: Available
    
    func mapGroupAvailableTotal(for categories: [Category]) -> [MonthYear: Decimal] {
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
    
    func mapAvailable(for category: CategoryPlain, from data: CombinedBudgetData) -> [MonthYear: Available] {
        
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
    
    // MARK: - Budget Accounts Plain to Entity
    
    //    func mapBudgetAccounts(from data: CombinedBudgetData) -> [BudgetAccount] {
    //        return data.budgetAccountsPlain.map { budgetAccountPlain in
    //            map(budgetAccountPlain: budgetAccountPlain, from: data)
    //        }
    //    }
    //
    //    func map(budgetAccountPlain: BudgetAccountPlain, from data: CombinedBudgetData) -> BudgetAccount {
    //        return BudgetAccount(
    //            id: budgetAccountPlain.id,
    //            nickname: budgetAccountPlain.nickname,
    //            accountType: budgetAccountPlain.accountType,
    //            startingBalance: budgetAccountPlain.startingBalance,
    //            notes: budgetAccountPlain.notes,
    //            isClosed: budgetAccountPlain.isClosed,
    //            transactions: map(
    //                transactionsPlain: budgetAccountPlain.transactions,
    //                payeesPlain: data.payeesPlain,
    //                categoryGroups: data.categoryGroupsPlain
    //            )
    //        )
    //    }
    
    // MARK: - Transactions Plain to Entity
    
    func map(transactionsPlain: [TransactionPlain], payeesPlain: [PayeePlain], categoryGroupsPlain: [CategoryGroupPlain]) -> [TransactionEntity] {
        return transactionsPlain.map { transaction in
            map(transactionPlain: transaction, payees: payeesPlain, categoryGroups: categoryGroupsPlain)
        }
    }
    
    func map(transactionPlain: TransactionPlain, payees: [PayeePlain], categoryGroups: [CategoryGroupPlain]) -> TransactionEntity {
        return TransactionEntity(
            date: transactionPlain.date,
            payee: mapPayee(payeeId: transactionPlain.payeeId, payees: payees, categoryGroups: categoryGroups),
            category: mapCategory(categoryId: transactionPlain.categoryId, categoryGroups: categoryGroups),
            amount: transactionPlain.amount,
            isCleared: transactionPlain.isCleared
        )
    }
    
    func mapPayee(payeeId: String?, payees: [PayeePlain], categoryGroups: [CategoryGroupPlain]) -> Payee? {
        if let payeePlain = payees.first(where: { payeeId == $0.id} ) {
            return mapPayee(payee: payeePlain, categoryGroups: categoryGroups)
        } else {
            // TODO: Need an Unknown Payee or Payee needs to be optional and need to propagate/handle that throughout the app etc...
            return Payee(id: "", name: "", aliases: [], includedInPayeeList: true, automaticallyCategorizeIsOn: true, defaultCategory: .groceries)
        }
    }
    
    func mapPayee(payee: PayeePlain, categoryGroups: [CategoryGroupPlain]) -> Payee {
        return Payee(
            id: payee.id,
            name: payee.name,
            aliases: payee.aliases,
            includedInPayeeList: payee.includedInPayeeList,
            automaticallyCategorizeIsOn: payee.automaticallyCategorizeIsOn,
            defaultCategory: mapCategory(categoryId: payee.defaultCategoryId, categoryGroups: categoryGroups)
        )
    }
    
    func mapCategory(categoryId: String?, categoryGroups: [CategoryGroupPlain]) -> TransactionCategory? {
        let categories = categoryGroups.flatMap { $0.categories }
        let matchingCategory = categories.first(where: { categoryId == $0.id })
        return TransactionMapper.map(categoryPlain: matchingCategory!) // TODO: Deal with explicit unwrap
    }
    
    // MARK: - Ready To Assign
    
    func mapReadyToAssign(from data: CombinedBudgetData) -> [MonthYear: ReadyToAssign] {
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
    
    func cashOverspendingLastMonth(for monthYear: MonthYear, from data: CombinedBudgetData) -> Decimal {
        return data.categoryGroupsPlain
            .flatMap { $0.categories }
            .compactMap { mapAvailable(for: $0, from: data)[monthYear.advanced(by: -1)] }
            .filter { $0.total < 0.00 }
            .compactMap { abs($0.total) } // am adding up negative ammounts so it produces a negative amount but I want the +ve total to add to other deductions on the outflows side of readyToAssign
            .reduce(0.00, +)
    }
    
    func inflow(for monthYear: MonthYear, from transactions: [TransactionPlain]) -> Decimal {
        return transactions
            .filter { $0.categoryId == "99" } // inflow TODO: Figure out how Inflow category works/maps
            .filter { MonthYear(from: $0.date) == monthYear }
            .compactMap { $0.amount.value }
            .reduce(0.00, +)
    }
    
    func assignedThisMonth(for monthYear: MonthYear, in categories: [CategoryPlain]) -> Decimal {
        return categories
            .compactMap { $0.assigned[monthYear] }
            .reduce(0.00, +)
    }
    
    // Calculated the actual value of future assignments
    func assignedInFuture(for monthYear: MonthYear, in categories: [CategoryPlain]) -> Decimal {
        return categories
            .flatMap { $0.assigned }// [(MonthYear, Decimal)] Flattens to tuples
            .filter { $0.key > monthYear } // [(MonthYear, Decimal)] Filtered
            .map { $0.value } // [Decimal]
            .reduce(0.00, +)
    }
    
    func budgetRange(from data: CombinedBudgetData) -> ClosedRange<MonthYear> {
        return mapBudgetStart(from: data)...mapBudgetEnd(from: data)
    }
    
    func mapBudgetStart(from data: CombinedBudgetData) -> MonthYear {
        let earliestActivityMonthYear = data.budgetAccountsPlain
            .flatMap { $0.transactions }
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
    
    func mapBudgetEnd(from data: CombinedBudgetData) -> MonthYear {
        let latestAssignedMonthYear = data.categoryGroupsPlain
            .flatMap { $0.categories } // [Categories]
            .flatMap { $0.assigned } // [MonthYear: Decimal]
            .compactMap { $0.key }.sorted(by: <) // [MonthYear] ordered chronologically
            .last ?? .currentMonthYear // MonthYear?
        return max(latestAssignedMonthYear.advanced(by: 1), .currentMonthYear.advanced(by: 1))
    }
    
    // MARK: - Category Entities to CategoryPlain
    
    func map(categoryGroups: [CategoryGroupEntity]) -> [CategoryGroupPlain] {
        categoryGroups.map { categoryGroup in
            map(categoryGroup: categoryGroup)
        }
    }
    
    func map(categoryGroup: CategoryGroupEntity) -> CategoryGroupPlain {
        return CategoryGroupPlain(
            id: categoryGroup.id,
            name: categoryGroup.name,
            isHidden: categoryGroup.isHidden,
            categories: map(categoryEntities: categoryGroup.categories)
        )
    }
    
    func map(categoryEntities: [CategoryEntity]) -> [CategoryPlain] {
        categoryEntities.map { category in
            map(category: category)
        }
    }
    
    func map(category: CategoryEntity) -> CategoryPlain {
        return CategoryPlain(
            id: category.id,
            name: category.name,
            notes: category.notes,
            isHidden: category.isHidden,
            assigned: category.assigned
        )
    }
}


enum TransactionMapper {
    static func map(transactionsPlain: [TransactionPlain], fromPayees payees: [PayeePlain], andCategoryGroups categoryGroups: [CategoryGroupPlain]) -> [TransactionEntity] {
        return transactionsPlain.map { transactionPlain in
            map(transactionPlain: transactionPlain, fromPayees: payees, andCategoryGroups: categoryGroups)
        }
    }
    
    static func map(transactionPlain: TransactionPlain, fromPayees payees: [PayeePlain], andCategoryGroups categoryGroups: [CategoryGroupPlain]) -> TransactionEntity {
        return TransactionEntity(
            date: transactionPlain.date,
            payee: map(payeeId: transactionPlain.payeeId, payeesPlain: payees, categoryGroups: categoryGroups),
            category: mapCategory(categoryId: transactionPlain.categoryId, categoryGroups: categoryGroups),
            amount: transactionPlain.amount,
            isCleared: transactionPlain.isCleared
        )
    }
    
    static func map(payeeId: String?, payeesPlain: [PayeePlain], categoryGroups: [CategoryGroupPlain]) -> Payee? {
        guard let payeePlain = payeesPlain.first(where: { payeeId == $0.id }) else { return nil }
        return map(payeePlain: payeePlain, categoryGroups: categoryGroups)
    }
    
    static func map(payeePlain: PayeePlain, categoryGroups: [CategoryGroupPlain]) -> Payee {
        return Payee(
            id: payeePlain.id,
            name: payeePlain.name,
            aliases: payeePlain.aliases,
            includedInPayeeList: payeePlain.includedInPayeeList,
            automaticallyCategorizeIsOn: payeePlain.automaticallyCategorizeIsOn,
            defaultCategory: mapCategory(categoryId: payeePlain.defaultCategoryId, categoryGroups: categoryGroups)
        )
    }
    
    static func mapCategory(categoryId: String?, categoryGroups: [CategoryGroupPlain]) -> TransactionCategory? {
        let categories = categoryGroups.flatMap { $0.categories } // [CategoryPlain]
        guard let matchingCategory = categories.first(where: { categoryId == $0.id }) else { return nil }
        return map(categoryPlain: matchingCategory)
    }
    
    static func map(categoryPlain: CategoryPlain) -> TransactionCategory {
        return TransactionCategory(id: categoryPlain.id, name: categoryPlain.name)
    }
}
