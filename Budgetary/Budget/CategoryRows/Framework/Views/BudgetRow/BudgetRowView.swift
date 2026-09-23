//
//  BudgetRowView.swift
//  Budgetary
//
//  Created by Phillip Baker on 08/08/2024.
//

import SwiftUI

struct BudgetRowView<BudgetRow: BudgetRowPresentation>: View {
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    let monthYear: MonthYear
    let budgetRow: BudgetRow
    
    enum FocusedField: Hashable {
        case primary(id: BudgetRowID?)
        case secondary(id: BudgetRowID?)
    }
    
    @FocusState var focusedField: FocusedField?
    @Binding var localValues: AssignedValues
    
    let action: (BudgetAction) -> Void
    
    var body: some View {
        let rowLayout = isXL
        ? AnyLayout(VStackLayout(alignment: .trailing, spacing: 8))
        : AnyLayout(HStackLayout())
        
        let amountsLayout = isAX3
        ? AnyLayout(VStackLayout(alignment: .trailing, spacing: 4))
        : AnyLayout(HStackLayout(spacing: 4))
        
        Button {
            focusedField = .primary(id: budgetRow.id)
        } label: {
            rowLayout {
                Text(budgetRow.name)
                    .frame(
                        maxWidth: .infinity,
                        alignment: isXL ? .trailing : .leading
                    )
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
                            rowID: budgetRow.id,
                            monthYear: monthYear,
                            currencyCode: "GBP",
                            action: action,
                            localValues: $localValues,
                            focusedField: _focusedField
                        )
                    }
                    
                    if horizontalSizeClass == .regular {
                        VStack(alignment: .trailing, spacing: 4) {
                            if isXL {
                                Text("Activity")
                                    .font(.caption)
                            }
                            NumberView(number: budgetRow.activity[monthYear]?.activityTotal ?? "0.00")
                                .fontWeight(.medium)
                        }
                    }
                    
                    VStack(alignment: .trailing, spacing: 4) {
                        if isXL {
                            Text("Available")
                                .font(.caption)
                        }
                        AvailableView(
                            available: budgetRow.available[monthYear] ?? CategoryAvailablePresentation(
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
    @Previewable @State var localValues = AssignedValues(
        primary: 9.99,
        secondary: 0.00,
        operation: .add,
        lastCommitted: 0.00,
        primaryIsNegative: false
    )
    
    BudgetRowView(
        monthYear: .currentMonthYear,
        budgetRow: CategoryPreview.cellPhones,
        localValues: $localValues,
        action: { _ in }
    )
    .padding()
}
