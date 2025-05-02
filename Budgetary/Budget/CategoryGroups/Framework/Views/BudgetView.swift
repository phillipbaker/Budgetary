//
//  BudgetView.swift
//  Budgetary
//
//  Created by Phillip Baker on 07/08/2024.
//

import Factory
import SwiftUI
import SwiftUINavigation

struct BudgetView: View {
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @Environment(\.horizontalSizeClass) var horizontalSize
    @Environment(BudgetCoordinator.self) var coordinator
    
    let budget: BudgetPresentation
    let intent: (BudgetIntent) -> Void

    @State private var assignedValues: [String: AssignedValue] = [:]
    @State private var keyboardHeight: CGFloat = 0
    
    var body: some View {
        @Bindable var coordinator = coordinator
        List {
            Section {
                // TODO: Fix need for this ?? default value
                ReadyToAssignView(
                    readyToAssign: budget.readyToAssign[budget.monthYear] ?? ReadyToAssignPresentation(
                        readyToAssignFromLastMonth: "",
                        cashOverspendingFromLastMonth: "",
                        inflowThisMonth: "",
                        assignedThisMonth: "",
                        assignedInFuture: "",
                        readyToAssignThisMonth: "",
                        lightModeForegroundColor: .red,
                        darkModeForegroundColor: .red,
                        lightModeBackgroundColor: .red,
                        darkModeBackgroundColor: .red,
                        message: ""
                    ),
                    buttonAction: {}
                )
            }
            .padding(.horizontal)
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            
            Section {
                FilterCategoriesView(
                    filter: budget.filter,
                    filterIntent: { id in intent(.filterButtonTapped(monthYear: budget.monthYear, filterId: id)) }
                )
            }
            .listRowSeparator(.hidden)
            .scrollIndicators(.hidden)
            .listRowBackground(Color(.systemGroupedBackground))
            
            Section {
                if budget.categoryGroups.isEmpty {
                    CategoryListEmptyView(filter: budget.filter, monthYear: budget.monthYear, intent: intent)
                } else {
                    ForEach(budget.categoryGroups) { group in
                        Section {
                            ForEach(group.categories) { category in
                                CategoryRowView(
                                    monthYear: budget.monthYear,
                                    category: category,
                                    assignedLocalValue: bindingFor(monthYear: budget.monthYear, category: category),
                                    intent: intent
                                )
                            }
                            .transition(.move(edge: .top))
                        } header: {
                            CategoryGroupRowView(group: group, monthYear: budget.monthYear)
                                .frame(
                                    maxWidth: .infinity,
                                    alignment: dynamicTypeSize >= .xLarge && horizontalSize == .compact ? .trailing : .leading
                                )
                                .listRowBackground(Color(.systemGroupedBackground))
                                .listSectionSeparator(.hidden)
                        }
                    }
                }
            }
            
            Section {
                if budget.filter != .allCategories && !budget.categoryGroups.isEmpty {
                    Button("Clear Filter") {
                        intent(.clearFilterButtonTapped(monthYear: budget.monthYear))
                    }
                }
            }
        }
        .listStyle(.grouped)
        .listSectionSpacing(16)
        .contentMargins(.top, 12)
        .safeAreaPadding(.bottom, 24) // causing a jolt on keyboard dismiss
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.width > 50 {
                        guard budget.monthYear > budget.start && budget.monthYear <= budget.end else { return }
                        intent(.budgetSwipedLeftGesture(monthYear: budget.monthYear, filterId: budget.filter.id))
                    } else if value.translation.width < -50 {
                        guard budget.monthYear >= budget.start && budget.monthYear < budget.end else { return }
                        intent(.budgetSwipedRightGesture(monthYear: budget.monthYear, filterId: budget.filter.id))
                    }
                }
        )
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                BudgetMenu()
            }
            
            ToolbarItem(placement: .navigation) {
                HStack {
                    Button {
                        coordinator.monthPickerButtonTapped()
                    } label: {
                        MonthPickerButtonLabel(month: budget.monthYear.monthAbbreviated + " " + budget.monthYear.year.description)
                            .popover(isPresented: Binding($coordinator.destination.monthPicker), attachmentAnchor: .point(.bottom)) {
                                MonthPickerView(
                                    year: budget.monthYear.year,
                                    monthYear: budget.monthYear,
                                    months: budget.months,
                                    filter: budget.filter,
                                    intent: intent
                                )
                            }
                    }
                    
                    if budget.monthYear != .currentMonthYear {
                        TodayButton(intent: intent, filter: budget.filter)
                    }
                }
            }
        }
        .sheet(isPresented: Binding($coordinator.destination.editCategories)) {
            EditCategoriesRootView()
        }
    }
    
    private func bindingFor(monthYear: MonthYear, category: CategoryPresentation) -> Binding<AssignedValue> {
        let key = "\(monthYear.description)-\(category.id.description)"
        
        return Binding(
            get: { assignedValues[key, default: AssignedValue(
                primary: category.assigned[monthYear]?.assignedThisMonth ?? "",
                secondary: Decimal(0).formatted(.currency(code: "GBP")),
                operation: "",
                lastCommitted: Decimal(0).formatted(.currency(code: "GBP"))
            )]},
            set: { assignedValues[key] = $0 }
        )
    }
}

#Preview {
    BudgetView(budget: .mock, intent: { _ in })
}
