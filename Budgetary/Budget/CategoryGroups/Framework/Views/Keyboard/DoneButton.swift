//
//  DoneButton.swift
//  Budgetary
//
//  Created by Phillip Baker on 19/05/2025.
//

import SwiftUI

struct DoneButton: View {
    let onSubmit: () -> Void
    @State private var isTapped: Bool = false
    
    var body: some View {
        Button("done") {
            onSubmit()
            isTapped.toggle()
        }
        .font(.body)
        .fontWeight(.semibold)
        .buttonStyle(.borderedProminent)
        .sensoryFeedback(.impact(weight: .light), trigger: isTapped)
    }
}

#Preview {
    DoneButton(onSubmit: {})
}
