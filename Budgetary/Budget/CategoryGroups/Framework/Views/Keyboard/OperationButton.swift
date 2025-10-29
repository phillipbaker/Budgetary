//
//  OperationButton.swift
//  Budgetary
//
//  Created by Phillip Baker on 19/05/2025.
//

import SwiftUI

struct OperationButton: View {
    let title: String
    let image: String
    let action: ((String) -> Void)
    @State private var isTapped: Bool = false
    
    var body: some View {
        Button {
            action(title)
            isTapped.toggle()
        } label: {
            Image(systemName: image)
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
    OperationButton(
        title: "",
        image: "",
        action: { _ in }
    )
}
