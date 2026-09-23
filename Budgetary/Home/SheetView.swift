//
//  SheetView.swift
//  Budgetary
//
//  Created by Phillip Baker on 29/01/2026.
//

import SwiftUI

struct SheetView: View {
    let sheet: Sheet
    
    var body: some View {
        switch sheet {
        case .transactionSheet:
            TransactionRootView()
        case .addAccountSheet:
            AddAccountView()
        }
    }
}

#Preview {
    SheetView(sheet: .transactionSheet)
}
