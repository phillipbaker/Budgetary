//
//  CategoryPickerRootView.swift
//  Budgetary
//
//  Created by Phillip Baker on 10/05/2025.
//

import SwiftUI

struct CategoryPickerRootView: View {
    @State private var model: CategoryPickerViewModel
    
    init(onSelect: @escaping (TransactionCategoryPresentation) -> Void) {
        _model = State(wrappedValue: CategoryPickerViewModel(onSelect: onSelect))
    }
    
    var body: some View {
        switch model.viewState {
        case .notLoaded:
            EmptyView()
        case .loading:
            ProgressView()
        case .error:
            Text("Error view goes here")
        case .loaded:
            CategoryPickerView(model: model)
        }
    }
}

#Preview {
    CategoryPickerRootView(onSelect: { _ in })
}
