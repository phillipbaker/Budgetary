//
//  Array+Decimal.swift
//  Budgetary
//
//  Created by Phillip Baker on 05/12/2025.
//

import Foundation

extension Array where Element == Decimal {
    var reduced: Decimal {
        self.reduce(0.00, +)
    }
}
