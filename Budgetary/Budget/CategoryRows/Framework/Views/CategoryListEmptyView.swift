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
            
            if monthYear == .currentMonthYear {
                // Current Month
                Text("You have no \(filter.rawValue) categories this month.")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
            } else if monthYear.year == .currentYear && monthYear.month < .currentMonth {
                // Past months this year
                Text("You had no \(filter.rawValue) categories in \(monthYear.monthWide).")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
            } else if monthYear.year < .currentYear {
                // Past months in previous years
                Text("You had no \(filter.rawValue) categories in \(monthYear.description).")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
            } else {
                // Future months
                Text("You have no \(filter.rawValue) categories in \(monthYear.description).")
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
