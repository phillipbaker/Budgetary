//
//  CategoryListEmptyView.swift
//  Budgetary
//
//  Created by Phillip Baker on 03/10/2024.
//

import SwiftUI

struct CategoryListEmptyView: View {
    @Binding var filter: CategoryFilter
    @Binding var selectedMonthYear: MonthYear
    
    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "checkmark.seal")
                .symbolRenderingMode(.hierarchical)
                .font(.largeTitle)
                .imageScale(.large)
            
            // Fix with grammar agreement?
            // Put current month year and/or selectedMonthYear into Environemnt for global use?
            if selectedMonthYear == .currentMonthYear {
                Text("You have no \(filter.rawValue) categories this month.")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
            } else if selectedMonthYear.year == .currentYear && selectedMonthYear.month != .currentMonth {
                Text("You had no \(filter.rawValue) categories in \(selectedMonthYear.monthWide).")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
            } else {
                Text("You had no \(filter.rawValue) categories in \(selectedMonthYear.description)")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
            }
            
            Button {
                filter = .allCategories
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
    CategoryListEmptyView(filter: .constant(.allCategories), selectedMonthYear: .constant(.currentMonthYear))
}
