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
        }
        .font(.title)
        .sensoryFeedback(.impact(weight: .light), trigger: isTapped)
    }
}

#Preview {
    OperationButton(
        title: "",
        image: "",
        action: { _ in }
    )
}
