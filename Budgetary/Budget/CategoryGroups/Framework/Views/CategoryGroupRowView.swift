//
//  CategoryGroupRowView.swift
//  Budgetary
//
//  Created by Phillip Baker on 08/08/2024.
//

import Foundation
import SwiftUI

struct CategoryGroupRowView: View {
    var group: CategoryGroupPresentation
    let monthYear: MonthYear
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        let rowLayout = isXL
        ? AnyLayout(VStackLayout(alignment: .trailing))
        : AnyLayout(HStackLayout(alignment: .lastTextBaseline))
        
        let amountsLayout = isAX3
        ? AnyLayout(VStackLayout(alignment: .trailing))
        : AnyLayout(HStackLayout(alignment: .lastTextBaseline, spacing: 4))
        
        rowLayout {
            Text(group.name)
                .frame(maxWidth: .infinity, alignment: isXL ? .trailing : .leading)
                .multilineTextAlignment(isXL ? .trailing : .leading)
                .font(.subheadline)
                .fontWeight(.semibold)
            
            amountsLayout {
                VStack(alignment: .trailing, spacing: 2) {
                    Text("Assigned")
                        .font(.caption)
                    NumberView(number: group.assignedTotal[monthYear] ?? "Error")
                        .fontWeight(.semibold)
                }

                if horizontalSizeClass == .regular {
                    VStack(alignment: .trailing, spacing: 2) {
                        Text("Activity")
                            .font(.caption)
                        NumberView(number: group.activityTotal[monthYear] ?? "Error")
                            .fontWeight(.semibold)
                    }
                }
                
                VStack(alignment: .trailing, spacing: 2) {
                    Text("Available")
                        .font(.caption)
                    NumberView(number: group.availableTotal[monthYear] ?? "")
                        .fontWeight(.semibold)
                }
                .offset(x: -8)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
    
    var isXL: Bool {
        dynamicTypeSize >= .xLarge && horizontalSizeClass == .compact
    }
    
    var isAX3: Bool {
        dynamicTypeSize >= .accessibility3
    }
}

#Preview {
    CategoryGroupRowView(
        group: .obligations,
        monthYear: .currentMonthYear
    )
    .padding()
}
