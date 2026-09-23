//
//  CreatePayeeButton.swift
//  Budgetary
//
//  Created by Phillip Baker on 12/06/2025.
//

import SwiftUI

struct NewPayeeButton: View {
    let action: () -> Void
    let searchText: String
    
    var body: some View {
        Button(action: action) {
            EmptyView()
                .overlay {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Create “\(searchText)” payee")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
        }
    }
}


#Preview {
    NewPayeeButton(action: {}, searchText: "")
}
