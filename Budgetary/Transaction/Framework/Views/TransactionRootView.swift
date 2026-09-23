//
//  TransactionRootView.swift
//  Budgetary
//
//  Created by Phillip Baker on 27/01/2026.
//

import SwiftUI

struct TransactionRootView: View {
    @State private var model: TransactionViewModel = TransactionViewModel()
    
    var body: some View {
        switch model.viewState {
        case .notLoaded:
            EmptyView() // TODO: - Figure out notLoaded -> loading -> loaded/error
        case .loading:
            ProgressView()
        case .error(let error):
            Text(error.localizedDescription)
        case .loaded:
            TransactionView(model: model)
        }
    }
}
