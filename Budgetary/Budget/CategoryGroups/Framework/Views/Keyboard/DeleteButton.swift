//
//  DeleteButton.swift
//  Budgetary
//
//  Created by Phillip Baker on 19/05/2025.
//

import SwiftUI

struct DeleteButton: View {
    let onDelete: () -> Void
    @State private var isTapped: Bool = false
    
    var body: some View {
        Button {
            onDelete()
            isTapped.toggle()
        } label: {
            Image(systemName: "delete.left")
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
    DeleteButton(onDelete: {})
}
