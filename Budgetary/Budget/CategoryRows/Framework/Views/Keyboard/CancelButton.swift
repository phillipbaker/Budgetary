//
//  CancelButton.swift
//  Budgetary
//
//  Created by Phillip Baker on 19/05/2025.
//

import SwiftUI

struct CancelButton: View {
    let onCancel: () throws -> Void
    @State private var isTapped: Bool = false
    
    var body: some View {
        Button("Cancel", role: .cancel) {
            do {
                try onCancel()
                isTapped.toggle()
            } catch {
                print(error)
            }
        }
        .frame(maxWidth: .infinity, minHeight: 48, maxHeight: .infinity)
        .tint(.primary)
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 22))
        .contentShape(RoundedRectangle(cornerRadius: 22))
        .sensoryFeedback(.impact(weight: .light), trigger: isTapped)
    }
}

#Preview {
    CancelButton(onCancel: {})
}
