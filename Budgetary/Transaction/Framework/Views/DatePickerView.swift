//
//  DatePickerButton.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/02/2026.
//

import SwiftUI

struct DatePickerView: View {
    let action: () -> Void
    let datePickerIsPresented: Bool

    @Binding var date: Date

    var body: some View {
        Button {
            withAnimation { // TODO: Is animation closure still needed?
                action()
            }
        } label: {
            HStack(spacing: 12) {
                Image(systemName: "calendar")
                    .frame(width: 32, height: 32)
                    .foregroundStyle(Color.accentColor)
                VStack(alignment: .leading) {
                    Text("Date")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(date.formatted(.dateTime.day().month().year()))
                        .foregroundStyle(datePickerIsPresented ? Color.accentColor : .primary)
                }
                .frame(minHeight: 40)
            }
            .tint(.primary)
        }
        
        if datePickerIsPresented {
            DatePicker("Transaction Date", selection: $date, displayedComponents: [.date])
                .labelsHidden()
                .datePickerStyle(.graphical)
                .id("datePicker")
            //                            .transition(.move(edge: .bottom))
        }
    }
}

#Preview {
    DatePickerView(
        action: {},
        datePickerIsPresented: false,
        date: .constant(.now)
    )
}
