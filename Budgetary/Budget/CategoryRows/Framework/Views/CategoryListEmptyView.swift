//
//  CategoryListEmptyView.swift
//  Budgetary
//
//  Created by Phillip Baker on 03/10/2024.
//

import SwiftUI

struct CategoryListEmptyView: View {
    var filter: CategoryFilterPresentation
    var monthYear: MonthYear
    
    let action: (BudgetAction) -> Void
    
    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "checkmark.seal")
                .symbolRenderingMode(.hierarchical)
                .font(.largeTitle)
                .imageScale(.large)
            
            // Fix with grammar agreement?
            // Put current month year and/or monthYear into Environemnt for global use?
            if monthYear == .currentMonthYear {
                Text("You have no \(filter.rawValue) categories this month.")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
            } else if monthYear.year == .currentYear && monthYear.month != .currentMonth {
                Text("You had no \(filter.rawValue) categories in \(monthYear.monthWide).")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
            } else {
                Text("You had no \(filter.rawValue) categories in \(monthYear.description)")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
            }
            
            Button {
                action(.clearFilterButtonTapped(filterID: filter.rawValue))
            } label: {
                Text("View All Categories")
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

#Preview {
    CategoryListEmptyView(filter: CategoryFilterPresentation.allCategories, monthYear: MonthYear.currentMonthYear, action: {_ in })
}
