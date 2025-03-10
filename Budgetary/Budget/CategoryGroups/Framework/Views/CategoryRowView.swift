//
//  CategoryRowView.swift
//  Budgetary
//
//  Created by Phillip Baker on 08/08/2024.
//

import SwiftUI

struct CategoryRowView: View {
    let monthYear: MonthYear
    let category: CategoryPresentation
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    let intent: (BudgetIntent) -> Void
    
    @Binding var assignedValues: [String: String]
    
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        let rowLayout = isXL
        ? AnyLayout(VStackLayout(alignment: .trailing, spacing: 8))
        : AnyLayout(HStackLayout())
        
        let amountsLayout = isAX3
        ? AnyLayout(VStackLayout(alignment: .trailing, spacing: 4))
        : AnyLayout(HStackLayout(spacing: 4))
        
        Button {
            isTextFieldFocused = true
        } label: {
            rowLayout {
                Text(category.name)
                    .frame(
                        maxWidth: .infinity,
                        alignment: isXL ? .trailing : .leading
                    )
                    .padding(.vertical, 2)
                    .font(.subheadline)
                    .lineLimit(isXL ? nil : 1)
                    .multilineTextAlignment(isXL ? .trailing : .leading)
                    .transition(.opacity)
                
                amountsLayout {
                    VStack(alignment: .trailing, spacing: 4) {
                        if isXL {
                            Text("Assigned")
                                .font(.caption)
                        }

                        AssignMoneyView(
                            category: category,
                            monthYear: monthYear,
                            currencyCode: "GBP",
                            intent: intent,
                            assignedValues: $assignedValues,
                            isTextFieldFocused: _isTextFieldFocused
                        )
                    }

                    if horizontalSizeClass == .regular {
                        VStack(alignment: .trailing, spacing: 4) {
                            if isXL {
                                Text("Activity")
                                    .font(.caption)
                            }
                            NumberView(number: category.activity[monthYear]?.total ?? "0.00")
                        }
                    }
                    
                    VStack(alignment: .trailing, spacing: 4) {
                        if isXL {
                            Text("Available")
                                .font(.caption)
                        }
                        AvailableView(
                            available: category.available[monthYear] ?? AvailablePresentation(
                                total: "0.00",
                                cashFromLastMonth: "0.00",
                                assignedThisMonth: "0.00",
                                cashSpendingThisMonth: "0.00",
                                message: "",
                                lightModeForegroundColor: .primary,
                                lightModeBackgroundColor: .secondary,
                                darkModeForegroundColor: .primary,
                                darkModeBackgroundColor: .secondary,
                                maxAvailableForReassignment: 0.00
                            )
                        )
                    }
                }
            }
        }
        .tint(.primary)
    }
    
    var isXL: Bool {
        dynamicTypeSize >= .xLarge && horizontalSizeClass == .compact
    }
    
    var isAX3: Bool {
        dynamicTypeSize >= .accessibility3
    }
}

#Preview {
    CategoryRowView(
        monthYear: .currentMonthYear,
        category: .cellPhones,
        intent: { _ in },
        assignedValues: .constant([:])
    )
    .padding()
}
