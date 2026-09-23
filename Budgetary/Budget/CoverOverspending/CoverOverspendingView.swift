//
//  CoverOverspendingView.swift
//  Budgetary
//
//  Created by Phillip Baker on 08/10/2024.
//

import SwiftUI

//struct CoverOverspendingView: View {
//    @Bindable var model: CoverOverspendingModel
//    @State var proposedReassignment: Double = 0.00
//    
//    var body: some View {
//        ZStack {
//            Color.red.mix(with: Color(.systemBackground), by: 0.8)
//                .ignoresSafeArea()
//            
//            VStack {
//                VStack(spacing: 16) {
//                    Text(model.categoryToCover?.name ?? "Select CategoryRow")
//                        .font(.title3)
//                    Text(model.categoryToCover?.available[model.selectedMonthYear]?.total ?? "£0.00")
//                        .font(.title)
//                        .fontWeight(.bold)
//                        .padding(.horizontal)
//                        .padding(.vertical, 4)
//                        .background(Color.red)
//                        .clipShape(Capsule(style: .continuous))
//                }
//                .padding()
//                
//                List {
//                    Color.clear
//                        .overlay {
//                            Text("Move \(model.totalToMove) from")
//                                .frame(maxWidth: .infinity, alignment: .center)
//                        }
//                        .foregroundStyle(.secondary)
//                    
//                    ForEach(model.selectedCoverFromCategories) { category in
//                        VStack {
//                            HStack {
//                                Text(category.name)
//                                    .frame(maxWidth: .infinity, alignment: .leading)
//                                HStack {
//                                    NumberView(number: category.proposedReassignment)
//                                    AvailableView(amount: (category.available[model.selectedMonthYear]?.total ?? "£0.00") - category.proposedReassignment)
//                                }
//                            }
//                            
//                            Slider(value: $proposedReassignment, in: 0...category.available[model.selectedMonthYear]?.maxAvailableForReassignment, step: 1)
//                        }
//                    }
//                    
//                    Button {
//                        model.selectCategoryButtonTapped()
//                    } label: {
//                        HStack {
//                            Image(systemName: "plus")
//                                .symbolVariant(.circle)
//                                .symbolVariant(.fill)
//                            Text(model.selectedCoverFromCategories.isEmpty ? "Select CategoryRow" : "Select Another")
//                                .fontWeight(.semibold)
//                        }
//                        .frame(maxWidth: .infinity)
//                    }
//                    .disabled(model.destination != nil)
//                }
//                .font(.subheadline)
//                .scrollContentBackground(.hidden)
//            }
//        }
////        .sheet(item: $model.destination.coverOverspendingFrom) { $coverOverspendingFromModel in
////            NavigationStack {
////                CoverOverspendingFromView(model: coverOverspendingFromModel)
////                    .navigationTitle("Cover overspending from")
////                    .navigationBarTitleDisplayMode(.inline)
////                    .presentationDetents([.medium, .large])
////            }
////        }
////        .sheet(item: $model.destination.overspentCategoryPicker) { $overspentCategoryPickerModel in
////            OverspentCategoryPickerView(model: overspentCategoryPickerModel)
////        }
//        
//    }
//}
//
//#Preview {
//    CoverOverspendingView(
//        model: CoverOverspendingModel(
//            selectedMonthYear: .currentMonthYear,
//            categoryToCover: .readyToAssign,
//            categoryGroups: [
//                .obligations,
//                .monthlyExpenses,
//                .trueExpenses
//            ]
//        )
//    )
//}
