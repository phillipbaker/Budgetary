//
//  CoverOverspendingFromView.swift
//  Budgetary
//
//  Created by Phillip Baker on 17/10/2024.
//

import SwiftUI

struct CoverOverspendingFromView: View {
    @Bindable var model: CoverOverspendingFromModel
    
    var body: some View {
        List {
            if model.filteredMoneyAvailableCategoryGroups.isEmpty {
                CoverOverspendingFromEmptyView(searchText: model.searchText)
            } else {
                ForEach($model.filteredMoneyAvailableCategoryGroups) { $group in
                    ForEach(group.categories) { category in
                        Button {
                            model.selectCategoryButtonTapped(for: category)
                        } label: {
                            HStack {
                                Text(category.name)
                                    .frame(maxWidth: .infinity, alignment: .leading)
//                                AvailableView(available: category.available)
                            }
                        }
                        .tint(.primary)
                    }
                }
            }
        }
        .searchable(
            text: $model.searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Search Categories"
        )
    }
}

#Preview {
    CoverOverspendingFromView(
        model: CoverOverspendingFromModel(
            selectedMonthYear: .currentMonthYear,
            moneyAvailableCategoryGroups: [.obligations, .trueExpenses, .monthlyExpenses, .fun]
        )
    )
}
