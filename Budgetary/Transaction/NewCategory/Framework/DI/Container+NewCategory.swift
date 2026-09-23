//
//  Container+NewCategory.swift
//  Budgetary
//
//  Created by Phillip Baker on 30/03/2026.
//

import Factory

extension Container {
    @MainActor
    var categoryGroupPickerViewModel: ParameterFactory<(CategoryGroupNamePresentation?, (CategoryGroupNamePresentation) -> Void), CategoryGroupPickerViewModel> {
        self { @MainActor in CategoryGroupPickerViewModel(selectedGroup: $0.0 ?? nil, onSelect: $0.1) }
    }
}
