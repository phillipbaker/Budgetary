//
//  CategoryRowDetailView.swift
//  Budgetary
//
//  Created by Phillip Baker on 24/09/2024.
//

import SwiftUI

struct CategoryRowDetailView: View {
    @State var selection = 1
    let monthYear: MonthYear
    let category: any BudgetRowPresentation
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(category.name)
                HStack {
                    Text("Assigned")
                    NumberView(number: category.assigned[monthYear]?.assignedThisMonth ?? "0.00")
                        .fontWeight(.medium)
                }
                HStack {
                    Text("Activity")
                    NumberView(number: category.activity[monthYear]?.activityTotal ?? "0.00")
                        .fontWeight(.medium)
                }
                HStack {
                    Text("Available")
                    NumberView(number: category.available[monthYear]?.total ?? "0.00")
                        .fontWeight(.medium)
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Picker("Detail", selection: $selection) {
                        Text("Assign")
                            .tag(1)
                        Text("Move Money")
                            .tag(2)
                        Text("Details")
                            .tag(3)
                    }
                    .pickerStyle(.segmented)
                }
            }
        }
    }
}

#Preview {
    CategoryRowDetailView(monthYear: .currentMonthYear, category: CategoryPreview.councilTax)
}
