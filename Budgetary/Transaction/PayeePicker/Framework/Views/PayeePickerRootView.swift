//
//  PayeePickerRootView.swift
//  Budgetary
//
//  Created by Phillip Baker on 09/05/2025.
//

import SwiftUI

struct PayeePickerRootView: View {
    @FocusState var focused: Bool
    @State private var model: PayeePickerViewModel
    
    init(onSelect: @escaping (PayeePresentation) -> Void) {
        _model = State(wrappedValue: PayeePickerViewModel(onSelect: onSelect))
    }
    
    var body: some View {
        Group {
            switch model.viewState {
            case .notLoaded:
                EmptyView()
            case .loading:
                ProgressView()
            case .error:
                Text("Error view goes here")
            case .loaded:
                PayeePickerView(model: model)
            }
        }
    }
}

#Preview {
    PayeePickerRootView(onSelect: { _ in })
}
