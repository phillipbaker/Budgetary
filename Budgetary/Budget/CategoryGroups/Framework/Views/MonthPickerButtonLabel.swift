//
//  MonthPickerButtonLabel.swift
//  Budgetary
//
//  Created by Phillip Baker on 24/09/2024.
//

import SwiftUI

struct MonthPickerButtonLabel: View {
    var month: String
    
    var body: some View {
        HStack(spacing: 4) {
            Text(month)
                .font(.title3)
                .fontWeight(.bold)
            Image(systemName: "chevron.down.circle")
                .imageScale(.medium)
                .symbolVariant(.fill)
                .foregroundStyle(.secondary)
                .symbolRenderingMode(.hierarchical)
        }
        .tint(.primary)
    }
}

#Preview {
    MonthPickerButtonLabel(month: "August 2024")
}
