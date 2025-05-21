//
//  KeypadNavigationButton.swift
//  Budgetary
//
//  Created by Phillip Baker on 19/05/2025.
//

import SwiftUI

struct KeypadNavigationButton: View {
    let title: String
    let image: String
    let action: () -> Void
    let tint: Color
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: image)
                    .frame(minWidth: 28, minHeight: 20)
                    .font(.title2)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 28)
                    .background(.secondary.opacity(0.16))
                    .tint(tint)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                Text(title)
                    .font(.caption)
                    .fontWeight(.regular)
                    .tint(.secondary)
            }
        }
    }
}

#Preview {
    KeypadNavigationButton(
        title: "",
        image: "",
        action: {},
        tint: .accentColor
    )
}
