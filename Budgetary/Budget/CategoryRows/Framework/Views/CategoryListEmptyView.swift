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
            
            Text(message)
                .font(.subheadline)
                .multilineTextAlignment(.center)
            
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
    
    private var message: String {
        let categories = "\(filter.rawValue) categories"
        guard monthYear != .currentMonthYear else {
            return "You have no \(categories) this month."
        }
        let verb = monthYear < .currentMonthYear ? "had" : "have"
        let month = monthYear.year == .currentYear ? monthYear.monthWide : monthYear.description
        return "You \(verb) no \(categories) in \(month)."
    }
}

#Preview {
    CategoryListEmptyView(filter: CategoryFilterPresentation.allCategories, monthYear: MonthYear.currentMonthYear, action: {_ in })
}
