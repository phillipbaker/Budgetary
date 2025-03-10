//
//  ReadyToAssignButtonLabel.swift
//  Budgetary
//
//  Created by Phillip Baker on 07/10/2024.
//

import SwiftUI

struct ReadyToAssignButtonLabel: View {
    let readyToAssign: ReadyToAssignPresentation
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(readyToAssign.readyToAssignThisMonth)
                .font(.headline)
            Text(readyToAssign.message)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .tint(.primary)
        .padding()
        .background(colorScheme == .light ? readyToAssign.lightModeBackgroundColor : readyToAssign.darkModeBackgroundColor)
        .foregroundStyle(colorScheme == .light ? readyToAssign.lightModeForegroundColor : readyToAssign.darkModeForegroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
