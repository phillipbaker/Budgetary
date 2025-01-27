//
//  OverspentCategoryPickerView.swift
//  Budgetary
//
//  Created by Phillip Baker on 17/10/2024.
//

import SwiftUI

struct OverspentCategoryPickerView: View {
    @Bindable var model: OverspentCategoryPickerModel
    
    var body: some View {
        Text("Overspent Categories")

        List {
            ForEach(model.overspentCategoryGroups) { group in
                Section {
                    ForEach(group.categories) { category in
                        HStack {
                            Text(category.name)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            AvailableView(
                                available: category.available[model.selectedMonthYear] ?? AvailablePresentation(
                                    total: "£0.00",
                                    cashFromLastMonth: "£0.00",
                                    assignedThisMonth: "£0.00",
                                    cashSpendingThisMonth: "£0.00",
                                    message: "",
                                    lightModeForegroundColor: .secondary,
                                    lightModeBackgroundColor: .secondary,
                                    darkModeForegroundColor: .secondary,
                                    darkModeBackgroundColor: .secondary,
                                    maxAvailableForReassignment: 0.00
                                )
                            )
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    OverspentCategoryPickerView(
        model: OverspentCategoryPickerModel(
            selectedMonthYear: .currentMonthYear,
            overspentCategoryGroups: [.obligations, .trueExpenses, .monthlyExpenses]
        )
    )
}
