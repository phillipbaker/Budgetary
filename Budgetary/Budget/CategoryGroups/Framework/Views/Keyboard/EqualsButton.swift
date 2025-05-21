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
        }
        .font(.title)
        .sensoryFeedback(.impact(weight: .light), trigger: isTapped)
    }
}

#Preview {
    EqualsButton(action: {})
}
