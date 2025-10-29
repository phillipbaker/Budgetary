//
//  EqualsButton.swift
//  Budgetary
//
//  Created by Phillip Baker on 19/05/2025.
//

import SwiftUI

struct EqualsButton: View {
    let action: () -> Void
    @State private var isTapped: Bool = false
    
    var body: some View {
        Button {
            action()
            isTapped.toggle()
        } label: {
            Image(systemName: "equal")
                .imageScale(.small)
        }
        .frame(maxWidth: .infinity, minHeight: 48, maxHeight: .infinity)
        .font(.title)
        .tint(.primary)
        .sensoryFeedback(.impact(weight: .light), trigger: isTapped)
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 22))
    }
}

#Preview {
    EqualsButton(action: {})
}
