//
//  ClearedToggleView.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/02/2026.
//

import SwiftUI

struct ClearedToggleView: View {
    @Binding var isCleared: Bool

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "c.circle")
                .frame(width: 32, height: 32)
                .symbolVariant(isCleared ? .fill : .none)
                .foregroundStyle(isCleared ? Color.accentColor : .secondary)
            Toggle("Cleared", isOn: $isCleared)
        }
        .frame(minHeight: 40)
    }
}

#Preview {
    ClearedToggleView(isCleared: .constant(false))
}
