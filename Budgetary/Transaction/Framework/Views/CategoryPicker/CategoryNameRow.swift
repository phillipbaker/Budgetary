//
//  CategoryNameRow.swift
//  Budgetary
//
//  Created by Phillip Baker on 12/06/2025.
//

import SwiftUI

struct CategoryNameRow: View {
    let action: (TransactionCategoryPresentation) -> Void
    let category: TransactionCategoryPresentation
    
    var body: some View {
        Button {
            action(category)
        } label: {
            Text(category.name)
        }
        .tint(.primary)
    }
}


#Preview {
    CategoryNameRow(
        action: { _ in },
        category: .init(id: "", name: "Groceries")
    )
}
