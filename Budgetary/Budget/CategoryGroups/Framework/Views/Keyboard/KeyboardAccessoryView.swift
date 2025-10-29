//
//  KeyboardAccessoryView.swift
//  Budgetary
//
//  Created by Phillip Baker on 17/10/2025.
//

import SwiftUI

struct KeyboardAccessoryView: View {
    @Environment(\.colorScheme) var colorScheme
    let destination: (AssignMoneyView.Destination?) -> Void
    
    var body: some View {
        HStack {
                Button(action: {}) {
                    VStack(spacing: 4) {
                        Image(systemName: "bolt")
                            .frame(minHeight: 24)
                            .imageScale(.large)
                            .tint(.secondary)
                        Text("Auto-Assign")
                            .font(.caption)
                    }
                    .frame(maxWidth: .infinity, minHeight: 48, maxHeight: .infinity)
                    .tint(.primary)
                    .padding(.vertical, 4)
                    .background(colorScheme == .light ? .white : .secondary)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            

                Button(action: { destination(.moveMoney) }) {
                    VStack(spacing: 4) {
                        Image(systemName: "arrow.left.arrow.right")
                            .frame(minHeight: 24)
                            .imageScale(.large)
                            .tint(.secondary)
                        Text("Move Money")
                            .font(.caption)
                    }
                    .frame(maxWidth: .infinity, minHeight: 48, maxHeight: .infinity)
                    .tint(.primary)
                    .padding(.vertical, 4)
                    .background(colorScheme == .light ? .white : .secondary)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }

            Button(action: { destination(.detail) }) {
                VStack(spacing: 4) {
                    Image(systemName: "ellipsis.circle")
                        .frame(minHeight: 24)
                        .imageScale(.large)
                        .tint(.secondary)
                    Text("Detail")
                        .font(.caption)
                }
                .frame(maxWidth: .infinity, minHeight: 48, maxHeight: .infinity)
                .tint(.primary)
                .padding(.vertical, 4)
                .background(colorScheme == .light ? .white : .secondary)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
        }
        .frame(maxWidth: .infinity)
        .font(.subheadline)
        .padding(.bottom, 4)
    }
}

#Preview {
    KeyboardAccessoryView(destination: { _ in })
}
