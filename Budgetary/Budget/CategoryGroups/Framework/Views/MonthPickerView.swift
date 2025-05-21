//
//  MonthPickerView.swift
//  Budgetary
//
//  Created by Phillip Baker on 08/08/2024.
//

import SwiftUI

struct MonthPickerView: View {
    let monthYear: MonthYear
    let months: [MonthPresentation]
    let filter: CategoryFilterPresentation
    let intent: (BudgetIntent) -> Void
    
    @State var year: Int
    @State private var sheetHeight: CGFloat = 0
    @Environment(BudgetCoordinator.self) var coordinator
    
    let columns = [
        GridItem(.flexible(minimum: 100, maximum: .infinity), alignment: .leading),
        GridItem(.flexible(minimum: 100, maximum: .infinity)),
        GridItem(.flexible(minimum: 100, maximum: .infinity), alignment: .trailing),
    ]
    
    var body: some View  {
        VStack {
            HStack {
                Button {
                    self.decrementYear()
                } label: {
                    Image(systemName: "chevron.left")
                }
                .disabled(year == months.first?.monthYear.year)
                
                Text(year.description)
                    .frame(maxWidth: .infinity)
                    .font(.headline)
                    .tint(.primary)
                
                Button {
                    self.incrementYear()
                } label: {
                    Image(systemName: "chevron.right")
                }
                .disabled(year == months.last?.monthYear.year)
            }
            .padding(8)
            
            Divider()
            
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(months) { month in
                    if month.monthYear.year == year {
                        Button {
                            intent(.monthPickerMonthSelected(monthYear: month.monthYear, filterId: filter.id))
                            coordinator.dismiss()
                        } label: {
                            Text(month.monthYear.monthAbbreviated)
                                .fontWeight(month.monthYear == monthYear ? .semibold : .regular)
                                .padding(.vertical, 12)
                                .padding(.horizontal)
                                .tint(month.monthYear == monthYear ? .white : .primary)
                                .background(month.backgroundColor)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .padding(.vertical, 6)
                        }
                        .disabled(month.isDisabled)
                    }
                }
            }
        }
        .frame(maxWidth: 400)
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .background {
            GeometryReader { proxy in
                Color.clear
                    .task { sheetHeight = proxy.size.height }
            }
        }
        .presentationDetents([.height(sheetHeight)])
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.width > 50 {
                        guard !(year == months.first?.monthYear.year) else { return }
                        self.decrementYear()
                    } else if value.translation.width < -50 {
                        guard !(year == months.last?.monthYear.year) else { return }
                        self.incrementYear()
                    }
                }
        )
        .onAppear {
            self.year = monthYear.year
        }
    }
    
    private func incrementYear() {
        self.year = self.year.advanced(by: 1)
    }
    
    private func decrementYear() {
        self.year = self.year.advanced(by: -1)
    }
}

#Preview {
    @Previewable @State var monthYear: MonthYear = .oct2024
    
    ZStack {
        Color.gray
            .ignoresSafeArea()
        MonthPickerView(
            monthYear: monthYear,
            months: [],
            filter: .allCategories,
            intent: { _ in },
            year: monthYear.year
        )
    }
}
