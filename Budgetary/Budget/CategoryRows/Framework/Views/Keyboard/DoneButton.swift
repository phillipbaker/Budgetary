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
        Button(role: .confirm) {
            onSubmit()
            isTapped.toggle()
        } label: {
            Image(systemName: "checkmark")
                .frame(maxWidth: .infinity, minHeight: 48, maxHeight: .infinity)
                .font(.title)
                .background(.tint)
                .imageScale(.small)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 22))
        }
        .contentShape(RoundedRectangle(cornerRadius: 22))
        .sensoryFeedback(.impact(weight: .light), trigger: isTapped)
    }
}

#Preview {
    DoneButton(onSubmit: {})
}
