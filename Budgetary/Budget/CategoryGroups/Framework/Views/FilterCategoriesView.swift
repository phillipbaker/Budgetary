//
//  CategoryFilterView.swift
//  Budgetary
//
//  Created by Phillip Baker on 25/09/2024.
//

import SwiftUI
import SwiftUINavigation

struct FilterCategoriesView: View {
    @Environment(\.colorScheme) var colorScheme
    
    let filter: CategoryFilterPresentation
    let filterIntent: (_ id: String) -> Void
    let destination: (BudgetViewModel.Destination) -> Void
    
    var body: some View {
        ScrollViewReader { value in
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(CategoryFilterPresentation.allCases) { filter in
                        Button {
                            filterIntent(filter.id)
                        } label: {
                            Text(filter.rawValue)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.vertical, 6)
                                .padding(.horizontal, 12)
                                .foregroundStyle(foreground(for: filter))
                                .background(background(for: filter))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                    
                    Menu {
                        Button {
                            destination(.manageFilters)
                        } label: {
                            Label("Manage Filters", systemImage: "pencil")
                        }
                        
                        Button {
                            destination(.newFilter)
                        } label: {
                            Label("New Filter", systemImage: "plus.circle")
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .font(.title3)
                            .tint(.primary)
                            .fontWeight(.semibold)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 12)
                            .foregroundStyle(.secondary.opacity(0.8))
                    }
                }
            }
            .onChange(of: filter) {
                withAnimation {
                    value.scrollTo(filter.id, anchor: .trailing)
                }
            }
        }
    }
    
    func foreground(for filter: CategoryFilterPresentation) -> Color {
        return isActive(filter) ? Color.accentColor : .secondary
    }
    
    func background(for filter: CategoryFilterPresentation) -> Color {
        switch (isActive(filter), colorScheme == .light) {
        case (true, true):
            Color.accentColor.opacity(0.2)
        case (true, false):
            Color.accentColor.opacity(0.2)
        case (false, true):
            Color(.systemBackground)
        case (false, false):
            Color(.secondarySystemBackground)
        }
    }
    
    func isActive(_ filter: CategoryFilterPresentation) -> Bool {
        filter == self.filter
    }
}


//#Preview {
//    FilterCategoriesView(viewModel: )
//}
