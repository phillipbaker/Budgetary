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
                .imageScale(.small)
        }
        .frame(maxWidth: .infinity, minHeight: 48, maxHeight: .infinity)
        .font(.title)
        .background(.tint)
//        .fontWeight(.semibold)
//        .buttonStyle(.borderedProminent)
        .sensoryFeedback(.impact(weight: .light), trigger: isTapped)
        .foregroundStyle(.white)
        .clipShape(RoundedRectangle(cornerRadius: 22))
    }
}

#Preview {
    DoneButton(onSubmit: {})
}
