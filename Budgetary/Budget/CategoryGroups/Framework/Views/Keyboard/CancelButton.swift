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
        Button("Cancel", role: .cancel) {
            onCancel()
            isTapped.toggle()
        }
        .frame(maxWidth: .infinity, minHeight: 48, maxHeight: .infinity)
        .tint(.primary)
        .sensoryFeedback(.impact(weight: .light), trigger: isTapped)
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 22))
    }
}

#Preview {
    CancelButton(onCancel: {})
}
