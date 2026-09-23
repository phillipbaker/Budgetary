//
//  CategoryNameRow.swift
//  Budgetary
//
//  Created by Phillip Baker on 12/06/2025.
//

import SwiftUI

struct CategoryNameRow: View {
    let category: TransactionCategoryPresentation
    let onSelect: (TransactionCategoryPresentation) -> Void
    
    var body: some View {
        Button {
            onSelect(category)
        } label: {
            Text(category.name)
        }
        .tint(.primary)
    }
}

#Preview {
    CategoryNameRow(
        category: .init(id: .init(), name: "Groceries"),
        onSelect: { _ in }
    )
}
