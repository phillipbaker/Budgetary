//
//  AssignMoneyUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 01/11/2024.
//

import Dependencies
import Foundation

//public class AssignMoneyUseCase {
//    // This encompasses lots of ways to assign money and could be multiple use cases for instance the assign money sheet, or just tapping into the list you can assign money to a category....
//    // This came from Category entity...
//    
//    public init() {}
//    
//    func updateAssigned(for Month: MonthYear, to newAmount: Decimal) {
////        self.assigned[Month] = newAmount
//    }
//}

public class AssignMoneyUseCase {
    var source: AssignMoneySource
    
    public init(source: AssignMoneySource) {
        self.source = source
    }
    
    func displayAssignMoneyView() {
//        self.destination = .assignMoney(
//            AssignMoneyModel(
//                selectedMonthYear: selectedMonthYear,
//                categoryGroups: mapByPriority(groups: budget.categoryGroups),
//                readyToAssign: budget.readyToAssign[selectedMonthYear] ?? 0.00
//            )
//        )
    }
}

