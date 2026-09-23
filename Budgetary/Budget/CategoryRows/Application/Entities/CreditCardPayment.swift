//
//  CreditCardPayment.swift
//  Budgetary
//
//  Created by Phillip Baker on 08/12/2025.
//

import Foundation

public struct CreditCardPayment: Equatable, Hashable, Identifiable, Sendable {
    public let id: ID<CreditCardPayment>
    let name: String
    let isHidden: Bool
    let assigned: [MonthYear: Decimal]
    let accountID: UUID
    
    init(
        id: ID<CreditCardPayment>,
        name: String,
        isHidden: Bool = false,
        assigned: [MonthYear : Decimal] = [:],
        accountID: UUID
    ) {
        self.id = id
        self.name = name
        self.isHidden = isHidden
        self.assigned = assigned
        self.accountID = accountID
    }
    
    func updating(assignedAmount: Decimal, for monthYear: MonthYear) -> CreditCardPayment {
        return CreditCardPayment(
            id: self.id,
            name: self.name,
            isHidden: self.isHidden,
            assigned: self.assigned.merging([monthYear: assignedAmount]) { _, new in new },
            accountID: self.accountID
        )
    }
}

