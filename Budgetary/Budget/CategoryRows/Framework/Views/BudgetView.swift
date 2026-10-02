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
    let action: (BudgetAction) -> Void
    let state: BudgetPresentationState
    @Bindable var coordinator: AppCoordinator
    
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @Environment(\.horizontalSizeClass) var horizontalSize
    
    @State private var assignedValues: [BudgetRowKey: AssignedValues] = [:]
    @State private var keyboardHeight: CGFloat = 0
    
    var body: some View {
        List {
            Section {
                ReadyToAssignView(
                    readyToAssign: state.budget.readyToAssign,
                    buttonAction: {}
                )
            }
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            
            if !state.budget.creditCardPaymentGroup.categories.isEmpty {
                Section {
                    ForEach(state.budget.creditCardPaymentGroup.categories) { cardPayment in
                        BudgetRowView(
                            monthYear: state.monthYear,
                            budgetRow: cardPayment,
                            localValues: bindingFor(monthYear: state.monthYear, budgetRow: cardPayment),
                            action: action
                        )
                        .id(BudgetRowKey(rowID: ID<BudgetRowKey>(cardPayment.id), monthYear: state.monthYear))
                    }
                } header: {
                    BudgetGroupHeaderRowView(
                        group: state.budget.creditCardPaymentGroup,
                        monthYear: state.monthYear
                    )
                }
            }
            
            if state.budget.categoryGroups.isEmpty {
                CategoryListEmptyView(filter: state.filter, monthYear: state.monthYear, action: action)
            } else {
                ForEach(state.budget.categoryGroups) { group in
                    Section {
                        ForEach(group.categories) { category in
                            BudgetRowView(
                                monthYear: state.monthYear,
                                budgetRow: category,
                                localValues: bindingFor(monthYear: state.monthYear, budgetRow: category),
                                action: action
                            )
                            .id(BudgetRowKey(rowID: ID<BudgetRowKey>(category.id), monthYear: state.monthYear))
                            .contextMenu {
                                Button {
                                    
                                } label: {
                                    Label("Add Transaction", systemImage: "plus")
                                }
                                Button {
                                    
                                } label: {
                                    Label("View Activity", systemImage: "chart.line.uptrend.xyaxis")
                                }
                                Button {
                                    
                                } label: {
                                    Label("Move Money", systemImage: "arrow.left.arrow.right")
                                }
                                Button {
                                    
                                } label: {
                                    Label("Edit Target", systemImage: "target") // Add target if none?
                                }
                                Button {
                                    
                                } label: {
                                    Label("View Details", systemImage: "ellipsis")
                                }
                            }
                        }
                        .transition(.move(edge: .top))
                    } header: {
                        BudgetGroupHeaderRowView(group: group, monthYear: state.monthYear)
                            .frame(
                                maxWidth: .infinity,
                                alignment: dynamicTypeSize >= .xLarge && horizontalSize == .compact ? .trailing : .leading
                            )
                    }
                }
            }
        }
        .contentMargins(.top, 12)
        .listSectionSpacing(8)
        .safeAreaPadding(.bottom, 24) // TODO: causing a jolt on keyboard dismiss
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.width > 50 {
                        state.swipeLeftGesture()
                        action(.budgetSwipedLeftGesture(monthYear: state.monthYear))
                    } else if value.translation.width < -50 {
                        state.swipeRightGesture()
                        action(.budgetSwipedRightGesture(monthYear: state.monthYear))
                    }
                }
        )
        .toolbar {            
            ToolbarItem(placement: .navigation) {
                GlassEffectContainer {
                    HStack(spacing: 0) {
                        Button {
//                            coordinator.monthPickerButtonTapped()
                        } label: {
                            Text(state.monthYear.monthWide + " " + state.monthYear.year.description)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 8)
//                                .popover(
//                                    isPresented: $coordinator.destination.monthPicker,
//                                    attachmentAnchor: .point(.bottom)
//                                ) {
//                                    MonthPickerView(
//                                        monthYear: state.monthYear,
//                                        months: state.budget.months,
//                                        filter: state.filter,
//                                        action: action,
//                                        year: state.monthYear.year
//                                    )
//                                    .presentationCompactAdaptation(.popover)
//                                }
                        }
                        //                        .buttonStyle(.glass)
                        
                        if state.monthYear != .currentMonthYear {
                            TodayButton(action: action, filter: state.filter)
                            //                                .buttonStyle(.glass)
                        }
                    }
                }
            }
        }
    }
    
    private func bindingFor<Row: BudgetRowPresentation>(monthYear: MonthYear, budgetRow: Row) -> Binding<AssignedValues> {
        let key = BudgetRowKey(rowID: ID<BudgetRowKey>(budgetRow.id), monthYear: state.monthYear)
        
        return Binding(
            get: { assignedValues[key, default: AssignedValues(
                primary: budgetRow.assigned[monthYear]?.assignedThisMonth.decimalValue ?? 0,
                secondary: 0,
                operation: nil,
                lastCommitted: 0,
                primaryIsNegative: false // TODO: Is this default a problem?
            )]},
            set: { assignedValues[key] = $0 }
        )
    }
}

#Preview {
    BudgetView(
        action: { _ in },
        state: BudgetPresentationState(
            budget: BudgetPresentation(
                id: ID<BudgetPresentation>.init(),
                monthYear: .currentMonthYear,
                months: [],
                readyToAssign: .mock,
                categoryGroups: [.obligations, .monthlyExpenses, .fun],
                creditCardPaymentGroup: .mock
            ),
            monthYear: .currentMonthYear,
            filter: .allCategories,
            swipeLeftGesture: {},
            swipeRightGesture: {}
        ),
        coordinator: .init()
    )
}

struct BudgetRowKey: Hashable {
    let rowID: ID<BudgetRowKey>
    let monthYear: MonthYear
}
