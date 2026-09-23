//
//  AccountPickerRootView.swift
//  Budgetary
//
//  Created by Phillip Baker on 02/02/2026.
//

import SwiftUI

struct AccountPickerRootView: View {
    @FocusState var focused: Bool
    @State private var model: AccountPickerViewModel
    
    init(onSelect: @escaping (TransactionAccountPresentation) -> Void) {
        _model = State(wrappedValue: AccountPickerViewModel(onSelect: onSelect))
    }
    
    var body: some View {
        VStack {
            switch model.viewState {
            case .notLoaded:
                EmptyView()
            case .loading:
                ProgressView()
            case .error:
                Text("Error view goes here")
            case .loaded:
                AccountPickerView(model: model)
            }
        }
    }
}

#Preview {
    AccountPickerRootView(onSelect: { _ in })
}
