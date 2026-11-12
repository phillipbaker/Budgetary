//
//  Array+CategoryRow.swift
//  Budgetary
//
//  Created by Phillip Baker on 05/12/2025.
//

import Foundation

extension [CategoryRow] {
    func mappedToAssignedAmounts(for monthYear: MonthYear) -> [Decimal] {
        self.compactMap { $0.assigned[monthYear]?.assignedThisMonth }
    }
}
