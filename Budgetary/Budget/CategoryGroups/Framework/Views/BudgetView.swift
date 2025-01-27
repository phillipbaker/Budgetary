//
//  BudgetView.swift
//  Budgetary
//
//  Created by Phillip Baker on 07/08/2024.
//

import SwiftUI
import SwiftUINavigation

struct BudgetRootView: View {
    @Bindable var viewModel: BudgetViewModel
    
    init(viewModel: BudgetViewModel) {
        self.viewModel = viewModel
        viewModel.handle(intent: .getBudget(
            monthYear: .oct2024,
            filterId: CategoryFilter.allCategories.id))
    }
    
    var body: some View {
        switch viewModel.state {
        case .loading:
            ProgressView()
        case .error:
            Text("Put Error View Here")
        case .success(let budget):
            NavigationStack {
                BudgetView(
                    budget: budget,
                    intent: { intent in viewModel.handle(intent: intent) },
                    destination: { destination in viewModel.handle(destination: destination) }
                )
                .toolbar {
                    ToolbarItem(placement: .navigation) {
                        HStack {
                            Button {
                                viewModel.handle(destination: .monthPicker)
                            } label: {
                                MonthPickerButtonLabel(month: budget.monthYear.monthAbbreviated + " " + budget.monthYear.year.description)
                                    .popover(isPresented: Binding($viewModel.destination.monthPicker), attachmentAnchor: .point(.bottom)) {
                                        MonthPickerView(
                                            year: budget.monthYear.year,
                                            monthYear: budget.monthYear,
                                            months: budget.months,
                                            filter: budget.filter,
                                            intent: { intent in
                                                viewModel.handle(intent: intent)
                                                // TODO: Can this go here?
                                                viewModel.handle(destination: nil)
                                            }
                                        )
                                    }
                            }

                            if budget.monthYear != .currentMonthYear {
                                TodayButton(
                                    intent: { intent in viewModel.handle(intent: intent) },
                                    filter: budget.filter
                                )
                            }
                        }
                    }
                    
                    ToolbarItem(placement: .primaryAction) {
                        BudgetMenu(destination: { destination in viewModel.handle(destination: destination)} )
                    }
                }
//                .sheet(item: $viewModel.destination.categoryDetail) { $detailModel in
//                    CategoryDetailView(model: detailModel)
//                }
//                .sheet(item: $viewModel.destination.editCategories) {
//                    EditCategoriesView(viewModel: <#EditCategoriesViewModel#>)
//                }
                //
                //            .sheet(item: $viewModel.destination.assignMoney) {
                //                AssignMoneyView(monthYear: budget.monthYear, categoryGroups: <#[CategoryGroupPresentation]#>, readyToAssign: <#ReadyToAssignPresentation#>)
                //            }
                //        .sheet(item: $viewModel.destination.coverOverspending) {
                //            CoverOverspendingView()
                //        }
                //        .sheet(item: $viewModel.destination.coverCategoryOverspending) {
                //            CoverOverspendingView()
                //        }
                //        .sheet(item: $viewModel.destination.manageFilters) {
                //            ManageFiltersView()
                //        }
                //        .sheet(item: $viewModel.destination?.newFilter) {
                //            NewFilterView()
                //        }
            }
        }
    }
}

struct BudgetView: View {
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @Environment(\.horizontalSizeClass) var horizontalSize
    
    let budget: BudgetPresentation
    let intent: (BudgetIntent) -> Void
    var destination: (BudgetViewModel.Destination?) -> Void
    
    var body: some View {
        List {
            Section {
                // TODO: Fix need for this ?? default value
                ReadyToAssignView(readyToAssign: budget.readyToAssign[budget.monthYear] ?? ReadyToAssignPresentation(
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
                            message: "",
                            destination: .assignMoney
                        ),
                    buttonAction: {
                        destination(
                            budget
                                .readyToAssign[budget.monthYear]?.destination
                        )
                    }
                )
            }
            .padding(.horizontal)
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            
            Section {
                FilterCategoriesView(
                    filter: budget.filter,
                    filterIntent: { id in intent(.filterButtonTapped(monthYear: budget.monthYear, filterId: id)) },
                    destination: { dest in destination(dest) }
                )
            }
            .listRowSeparator(.hidden)
            .scrollIndicators(.hidden)
            .listRowBackground(Color(.systemGroupedBackground))
            
            Section {
                ForEach(budget.categoryGroups) { group in
                    Section {
                        ForEach(group.categories) { category in
                            CategoryRowView(
                                monthYear: budget.monthYear,
                                category: category,
                                text: category.assigned[budget.monthYear]?.assignedThisMonth ?? "0.00"
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
            
            Section {
                if budget.filter != .allCategories && !budget.categoryGroups.isEmpty {
                    Button("Clear Filter", action: { intent(.clearFilterButtonTapped(monthYear: budget.monthYear)) })
                }
            }
        }
        .listStyle(.grouped)
        .listSectionSpacing(16)
        .contentMargins(.top, 12)
        
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.width > 50 {
                        intent(.budgetSwipedLeftGesture(monthYear: budget.monthYear, filterId: budget.filter.id))
                    } else if value.translation.width < -50 {
                        intent(.budgetSwipedRightGesture(monthYear: budget.monthYear, filterId: budget.filter.id))
                    }
                }
        )
    }
}

#Preview {
    BudgetView(budget: .mock, intent: { _ in }, destination: { _ in })
}
