//
//  AssignMoneyView.swift
//  Budgetary
//
//  Created by Phillip Baker on 28/01/2025.
//

import SwiftUI

struct AssignMoneyView: View {
    let category: CategoryPresentation
    let monthYear: MonthYear
    let currencyCode: String
    let intent: (BudgetIntent) -> Void
    let destination: (BudgetViewModel.Destination) -> Void
    
    @Binding var assignedValues: [String: String]
    
    @State private var amount: Decimal = 0.00
    
    @FocusState var isTextFieldFocused: Bool
    
    var body: some View {
        Text("£9,999,999.99")
            .foregroundStyle(.red)
            .hidden()
            .overlay(alignment: .trailing) {
                CurrencyTextField(
                    text: bindingFor(monthYear: monthYear, category: category),
                    category: category,
                    monthYear: monthYear,
                    currencyCode: currencyCode,
                    onTextChanged: { newValue in
                        updateLocalValue(newValue)
                    },
                    onUpdateAssignedValue: {
                        updateAssignedAmount()
                    }
                )
                .id(monthYear)
                .offset(x: -4)
                .fontWeight(.semibold)
                .focused($isTextFieldFocused)
            }
            .frame(minWidth: 112, alignment: .trailing)
            .font(.subheadline)
            .fontWeight(.semibold)
            .padding(.vertical, 2)
    }
    
    private func bindingFor(monthYear: MonthYear, category: CategoryPresentation) -> Binding<String> {
        let key = "\(monthYear.description)-\(category.id.description)"
        return Binding(
            get: { assignedValues[key, default: category.assigned[monthYear]?.assignedThisMonth ?? ""] },
            set: { assignedValues[key] = $0 }
        )
    }
    
    private func updateLocalValue(_ newValue: String) {
        let key = "\(monthYear.description)-\(category.id.description)"
        assignedValues[key] = newValue
    }
    
    private func updateAssignedAmount() {
        let key = "\(monthYear.description)-\(category.id.description)"
        guard let newValue = assignedValues[key] else { return }
        intent(.updateAssignedAmount(categoryId: self.category.id, monthYear: monthYear, amount: newValue))
    }
    
    private func initializeAssignedValues() {
        assignedValues.removeAll()
    }
}
