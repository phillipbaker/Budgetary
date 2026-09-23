//
//  TransactionFieldPickerButton.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/02/2026.
//

import SwiftUI

struct TransactionFieldPickerButton: View {
    let action: () -> Void
    let image: String
    let label: String
    let name: String?
    
    var body: some View {
        Button { action()
        } label: {
            HStack(spacing: 12) {
                Image(systemName: image)
                    .frame(width: 32, height: 32)
                    .foregroundStyle(name == nil ? Color.secondary : .accentColor)
                VStack(alignment: .leading) {
                    Text(label)
                        .font(name == nil ? .body : .caption)
                        .foregroundStyle(.secondary)
                    if let name {
                        Text(name)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.secondary)
                    .imageScale(.small)
                    .fontWeight(.semibold)
                    .opacity(0.5)
            }
            .frame(minHeight: 40)
            .tint(.primary)
        }
    }
}

#Preview {
    TransactionFieldPickerButton(
        action: {},
        image: "",
        label: "",
        name: ""
    )
}
