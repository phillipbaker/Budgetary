//
//  AvailableView.swift
//  Budgetary
//
//  Created by Phillip Baker on 10/09/2024.
//

import SwiftUI

struct AvailableView: View {
    var available: AvailablePresentation
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Text("£9,999,999.99")
            .foregroundStyle(.red)
            .hidden()
            .overlay(alignment: .trailing) {
                Text(available.total)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 8)
                    .background(
                        colorScheme == .light
                        ? available.lightModeBackgroundColor
                        : available.darkModeBackgroundColor
                    )
                    .foregroundStyle(
                        colorScheme == .light
                        ? available.lightModeForegroundColor
                        : available.darkModeForegroundColor
                    )
                    .clipShape(Capsule())
            }
            .offset(x: 4)
            .padding(.vertical, 2)
            .frame(minWidth: 112, alignment: .trailing)
            .font(.subheadline)
            .fontWeight(.semibold)

    }
}

#Preview {
    VStack {
        AvailableView(
            available: AvailablePresentation(
                total: "£34.00",
                cashFromLastMonth: "",
                assignedThisMonth: "",
                cashSpendingThisMonth: "",
                message: "",
                lightModeForegroundColor: .accentColor,
                lightModeBackgroundColor: .secondary,
                darkModeForegroundColor: .accentColor,
                darkModeBackgroundColor: .secondary,
                maxAvailableForReassignment: 0.00
            )
        )
    }
}
