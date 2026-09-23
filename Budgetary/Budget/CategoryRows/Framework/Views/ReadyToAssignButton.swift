//
//  ReadyToAssignButton.swift
//  Budgetary
//
//  Created by Phillip Baker on 22/11/2024.
//

import SwiftUI

struct ReadyToAssignView: View {
    @Environment(\.colorScheme) var colorScheme
    let readyToAssign: ReadyToAssignPresentation
    let buttonAction: () -> Void
    
    var body: some View {
        Button(action: buttonAction) {
            ReadyToAssignButtonLabel(readyToAssign: readyToAssign)
        }
    }
}
