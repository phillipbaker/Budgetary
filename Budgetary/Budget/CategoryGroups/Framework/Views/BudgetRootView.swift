//
//  BudgetRootView.swift
//  Budgetary
//
//  Created by Phillip Baker on 29/03/2025.
//

import SwiftUI
import SwiftUINavigation

struct BudgetRootView: View {
    @Bindable var viewModel: BudgetViewModel
    
    init(viewModel: BudgetViewModel) {
        self.viewModel = viewModel
        viewModel.handle(intent: .getBudget(
            monthYear: .currentMonthYear,
            filterId: CategoryFilter.allCategories.id)
        )
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
                                        .overlay(
                                            Rectangle()
                                                .frame(height: 1) // Border height
                                                .foregroundColor(Color.gray.opacity(0.5))
                                                .offset(y: -1),
                                            alignment: .top
                                        )
                                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: -2)
                                        .edgesIgnoringSafeArea(.bottom)
                                        .background(Color.black.opacity(0.3)) // Background overlay for sheet effect
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
                //                .sheet(isPresented: Binding($viewModel.destination.moveMoney), onDismiss: {  }) {
                //                    MoveMoneyView()
                //                }
                //                .sheet(isPresented: Binding($viewModel.destination.categoryDetail)) {
                //                    CategoryDetailView()
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
