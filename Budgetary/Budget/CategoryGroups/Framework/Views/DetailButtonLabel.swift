//
//  DetailButtonLabel.swift
//  Budgetary
//
//  Created by Phillip Baker on 09/03/2025.
//

import SwiftUI

struct DetailButtonLabel: View {
    let label: String
    let systemImage: String
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: systemImage)
                .frame(minWidth: 28, minHeight: 24)
                .padding(.vertical, 4)
                .padding(.horizontal, 24)
                .background(.secondary.opacity(0.15))
                .tint(.secondary)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            Text(label)
                .font(.caption2)
                .tint(.secondary)
        }
    }
}

#Preview {
    DetailButtonLabel(label: "", systemImage: "")
}
