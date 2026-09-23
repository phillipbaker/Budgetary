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
    let operation: AmountOperation
    let action: ((AmountOperation) -> Void)
    @State private var isTapped: Bool = false
    
    var body: some View {
        Button {
            action(operation)
            isTapped.toggle()
        } label: {
            Image(systemName: image)
                .frame(maxWidth: .infinity, minHeight: 48, maxHeight: .infinity)
                .font(.title)
                .tint(.primary)
                .imageScale(.small)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 22))
        }
        .contentShape(RoundedRectangle(cornerRadius: 22))
        .sensoryFeedback(.impact(weight: .light), trigger: isTapped)
    }
}

#Preview {
    OperationButton(
        title: "",
        image: "",
        operation: .add,
        action: { _ in }
    )
}
