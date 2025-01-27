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
                .tint(.primary)
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.vertical, 6)
                .padding(.horizontal, 12)
                .foregroundStyle(.secondary)
                .background(
                    Color(
                        colorScheme == .dark
                        ? .secondarySystemBackground
                        : .systemBackground
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}

#Preview {
    TodayButton(
        intent: { _ in },
        filter: .allCategories
    )
}
