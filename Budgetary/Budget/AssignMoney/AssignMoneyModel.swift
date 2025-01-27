//
//  AssignMoneyModel.swift
//  Budgetary
//
//  Created by Phillip Baker on 08/10/2024.
//

//import SwiftUI
//
//@Observable
//final class AssignMoneyModel: Identifiable {
//    var id: String = UUID().uuidString
//    
//    var selectedMonthYear: MonthYear
//    var categoryGroups: [CategoryGroupPresentation]
//    var readyToAssign: Decimal
//    
//    init(
//        selectedMonthYear: MonthYear,
//        categoryGroups: [CategoryGroupPresentation],
//        readyToAssign: Decimal
//    ) {
//        self.selectedMonthYear = selectedMonthYear
//        self.categoryGroups = categoryGroups
//        self.readyToAssign = readyToAssign
//    }
    
//    func status(for category: CategoryPresentation) -> String {
//        // MARK: TODO - Incorporate target logic
//        // if target (or switch on target/no target)
//            // return on track, underfunded or funded based on target logic
//        // else or no target switch case...
//        
//        // If no activity early out with empty string
//        guard category.activity != 0.00 else { return "" }
//        
//        let assigned = abs(category.assigned)
//        let activity = abs(category.activity)
//        let available = abs(category.available)
//
//        if assigned > activity {
//            return "Spent" + " \(activity.currency()) of \((available + activity).currency())"
//        } else if assigned < activity {
//            return "Overspent by \((activity - assigned).currency())"
//        } else {
//            return "Fully spent"
//        }
        
        // YNAB has separate "Cover Overspending" button that brings up overspent categories even when you have money left to assign - rethink this whole button?
//    }
//    
//    func barFill(for category: CategoryPresentation) {
//        // COLOR OF BARS
//        // if assigned and activity, filled as % of assigned i.e. if spent 90% of assigned, filled 90%
//        // if available == 0, unfilled
//        // if available +ve and no target bar filled
//        // if available +ve and target filled as % of target funded
//    }
//}
