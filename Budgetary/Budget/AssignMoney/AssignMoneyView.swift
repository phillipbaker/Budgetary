//
//  AssignMoneyView.swift
//  Budgetary
//
//  Created by Phillip Baker on 08/10/2024.
//

//import SwiftUI
//
//struct AssignMoneyView: View {
//    let monthYear: MonthYear
//    let categoryGroups: [CategoryGroupPresentation]
//    let readyToAssign: ReadyToAssignPresentation
//    
//    var body: some View {
//        VStack(spacing: 0) {
//            ReadyToAssignButtonLabel(readyToAssign: readyToAssign)
//                .padding()
//                .background(Color(.systemGroupedBackground))
//            List {
//                ForEach(categoryGroups) { group in
//                    Section {
//                        ForEach(group.categories) { category in
//                            VStack {
//                                HStack {
//                                    Text(category.name)
//                                        .frame(maxWidth: .infinity, alignment: .leading)
//                                    AvailableView(amount:  category.available[monthYear])
//                                        .offset(x: 4)
//                                }
//                                
//                                Capsule()
//                                    .frame(height: 6)
//                                    .foregroundStyle(.secondary.opacity(0.4))
//                                
//                                // Status related to target
//                                //                                Text(model.status(for: category))
//                                //                                    .frame(maxWidth: .infinity, alignment: .leading)
//                                //                                    .font(.caption)
//                                //                                    .foregroundStyle(.secondary)
//                            }
//                        }
//                    } header: {
//                        HStack {
//                            Text(group.name)
//                                .frame(maxWidth: .infinity, alignment: .leading)
//                            VStack(alignment: .trailing, spacing: 2) {
//                                Text("Available")
//                                NumberView(number: group.availableTotal[monthYear] ?? "0.00")
//                                    .offset(x: 4)
//                            }
//                        }
//                    }
//                }
//            }
//            .listStyle(.inset)
//        }
//    }
//}
//
//#Preview {
//    AssignMoneyView(
//        monthYear: .currentMonthYear,
//        categoryGroups: [.obligations, .monthlyExpenses, .trueExpenses],
//        readyToAssign: ReadyToAssignPresentation(
//            availableToAssignFromLastMonth: "availableToAssignFromLastMonth",
//            cashOverspendingFromLastMonth: "cashOverspendingFromLastMonth",
//            inflowThisMonth: "Infow",
//            assignedThisMonth: "Assigned",
//            assignedInFuture: "Assigned in Fure",
//            readyToAssignThisMonth: "readyToAssignThisMonth",
//            lightModeForegroundColor: .accentColor,
//            darkModeForegroundColor: .accentColor,
//            lightModeBackgroundColor: .gray,
//            darkModeBackgroundColor: .gray,
//            message: "Message goes here",
//            destination: .assignMoney
//        )
//    )
//}
