//
//  CancelButton.swift
//  Budgetary
//
//  Created by Phillip Baker on 19/05/2025.
//

import SwiftUI

struct CancelButton: View {
    let onCancel: () -> Void
    @State private var isTapped: Bool = false
    
    var body: some View {
        Button {
            onCancel()
            isTapped.toggle()
        } label: {
            Image(systemName: "x.circle.fill")
                .tint(.secondary.opacity(0.6))
        }
        .font(.title)
        .sensoryFeedback(.impact(weight: .light), trigger: isTapped)
    }
}

#Preview {
    CancelButton(onCancel: {})
}
