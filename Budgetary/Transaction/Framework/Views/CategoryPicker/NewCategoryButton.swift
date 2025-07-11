//
//  NewCategoryButton.swift
//  Budgetary
//
//  Created by Phillip Baker on 12/06/2025.
//

import SwiftUI

struct NewCategoryButton: View {
    let action: () -> Void
    let searchText: String
    
    var body: some View {
        Button(action: action) {
            EmptyView()
                .overlay {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Create “\(searchText)” category")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
        }
    }
}


#Preview {
    NewCategoryButton(action: {}, searchText: "")
}
