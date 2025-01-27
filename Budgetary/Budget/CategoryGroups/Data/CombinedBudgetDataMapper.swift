//
//  BudgetMonthDataMapper.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

public class CombinedBudgetDataMapper {
    func map(
        budgetPlain: BudgetPlain,
        payeesPlain: [PayeePlain],
        budgetAccountsPlain: [BudgetAccountPlain],
        categoryGroupsPlain: [CategoryGroupPlain]
        
    ) -> CombinedBudgetData {
        return CombinedBudgetData(
            budgetPlain: budgetPlain,
            payeesPlain: payeesPlain,
            budgetAccountsPlain: budgetAccountsPlain,
            categoryGroupsPlain: categoryGroupsPlain
        )
    }
}

//public class BudgetMonthDataMapper {
//    func map(
//        budgetPlain: BudgetPlain,
//        budgetAccountsPlain: [BudgetAccountPlain],
//        categoryGroupsPlain: [CategoryGroupPlain],
//        payeesPlain: [PayeePlain]
//    ) -> CombinedBudgetData {
//        return BudgetMonthData(
//            budgetPlain: budgetPlain,
//            budgetAccountsPlain: budgetAccountsPlain,
//            categoryGroupsPlain: categoryGroupsPlain,
//            payeesPlain: payeesPlain
//        )
//    }
//}
