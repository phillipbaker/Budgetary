//
//  TodayButton.swift
//  Budgetary
//
//  Created by Phillip Baker on 28/09/2024.
//

import SwiftUI

struct TodayButton: View {
    let action: (BudgetAction) -> Void
    let filter: CategoryFilterPresentation
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button {
            action(.monthPickerMonthSelected(monthYear: .currentMonthYear))
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
        action: { _ in },
        filter: .allCategories
    )
}
