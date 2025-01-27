//
//  CategoryListView.swift
//  Budgetary
//
//  Created by Phillip Baker on 08/08/2024.
//

import Foundation
import SwiftUI

struct CategoryListView: View {
    @Binding var filter: CategoryFilter
    @Binding var monthYear: MonthYear
    var categoryGroups: [CategoryGroupPresentation]
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @Environment(\.horizontalSizeClass) var horizontalSize
    
    var body: some View {
        switch categoryGroups.isEmpty {
        case true:
            CategoryListEmptyView(filter: $filter, selectedMonthYear: $monthYear)
        case false:
            ForEach(categoryGroups) { group in
                Section {
                    ForEach(group.categories) { category in
                        CategoryRowView(
                            monthYear: monthYear,
                            category: category,
                            text: "34.56"
                        )
                    }
                    .transition(.move(edge: .top))
                } header: {
                    CategoryGroupRowView(group: group, monthYear: monthYear)
                    .frame(maxWidth: .infinity, alignment: isXL ? .trailing : .leading)
                }
            }
        }
    }
    
    var isXL: Bool {
        dynamicTypeSize >= .xLarge && horizontalSize == .compact
    }
}

#Preview {
    CategoryListView(
        filter: .constant(.allCategories),
        monthYear: .constant(.sep2024),
        categoryGroups: [
            .obligations,
            .trueExpenses,
            .monthlyExpenses
        ]
    )
}
