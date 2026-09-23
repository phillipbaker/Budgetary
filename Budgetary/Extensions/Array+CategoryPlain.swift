//
//  Array+Mapping.swift
//  Budgetary
//
//  Created by Phillip Baker on 05/12/2025.
//

import Foundation

extension Array where Element == CategoryPlain {
    func mappedToAssignedAmounts(for monthYear: MonthYear) -> [Decimal] {
        self.compactMap { $0.assigned[monthYear] }
    }
}
