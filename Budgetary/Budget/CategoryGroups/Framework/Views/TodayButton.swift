//
//  TodayButton.swift
//  Budgetary
//
//  Created by Phillip Baker on 28/09/2024.
//

import SwiftUI

struct TodayButton: View {
    let intent: (BudgetIntent) -> Void
    let filter: CategoryFilterPresentation
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button {
            intent(.monthPickerMonthSelected(
                monthYear: .currentMonthYear,
                filterId: filter.id
            ))
        } label: {
            Text("Today")
                .tint(.secondary)
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.vertical, 4)
                .padding(.horizontal, 8)
                .background(
                    Color(
                        colorScheme == .dark
                        ? .systemGroupedBackground
                        : .systemGroupedBackground
                    )
                )
                .clipShape(Capsule())
        }
    }
}

#Preview {
    TodayButton(
        intent: { _ in },
        filter: .allCategories
    )
}
