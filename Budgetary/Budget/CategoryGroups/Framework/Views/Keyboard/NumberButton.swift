//
//  NumberButton.swift
//  Budgetary
//
//  Created by Phillip Baker on 19/05/2025.
//

import SwiftUI

struct NumberButton: View {
    @Environment(\.colorScheme) var colorScheme
    let number: String
    let insert: ((String) -> Void)
    @State private var isTapped: Bool = false
    
    var body: some View {
        Button {
            insert(number)
            isTapped.toggle()
        } label: {
            Text(number)
                .frame(maxWidth: .infinity, minHeight: 48, maxHeight: .infinity)
                .font(.title)
                .tint(.primary)
                .background(colorScheme == .light ? .white : .secondary)
                .clipShape(RoundedRectangle(cornerRadius: 22))
                .contentShape(Rectangle())
        }
        .sensoryFeedback(.impact(weight: .light), trigger: isTapped)
    }
}

#Preview {
    NumberButton(number: "", insert: { _ in })
}
