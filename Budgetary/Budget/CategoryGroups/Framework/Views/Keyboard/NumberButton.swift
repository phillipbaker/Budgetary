//
//  NumberButton.swift
//  Budgetary
//
//  Created by Phillip Baker on 19/05/2025.
//

import SwiftUI

struct NumberButton: View {
    let number: String
    let insert: ((String) -> Void)
    @State private var isTapped: Bool = false
    
    var body: some View {
        Button(number) {
            insert(number)
            isTapped.toggle()
        }
        .font(.title)
        .tint(.primary)
        .sensoryFeedback(.impact(weight: .light), trigger: isTapped)
    }
}

#Preview {
    NumberButton(number: "", insert: { _ in })
}
