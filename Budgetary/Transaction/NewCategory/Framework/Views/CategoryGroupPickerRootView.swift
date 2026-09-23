//
//  CategoryGroupPickerRootView.swift
//  Budgetary
//
//  Created by Phillip Baker on 18/03/2026.
//

import SwiftUI

struct CategoryGroupPickerRootView: View {
    @State private var model: CategoryGroupPickerViewModel
    
    init(
        selectedGroup: CategoryGroupNamePresentation?,
        onSelect: @escaping (CategoryGroupNamePresentation) -> Void
    ) {
        _model = State(
            wrappedValue: CategoryGroupPickerViewModel(
                selectedGroup: selectedGroup,
                onSelect: onSelect
            )
        )
    }
    
    var body: some View {
        switch model.viewState {
        case .notLoaded:
            EmptyView()
        case .loading:
            ProgressView()
        case .error:
            EmptyView()
        case .loaded:
            CategoryGroupPickerView(model: model)
        }
    }
}
