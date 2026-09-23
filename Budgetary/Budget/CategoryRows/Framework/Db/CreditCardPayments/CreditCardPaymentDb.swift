//
//  CreditCardPaymentDb.swift
//  Budgetary
//
//  Created by Phillip Baker on 27/11/2025.
//

import Foundation
import SwiftData

@Model
final class CreditCardPaymentDb: Equatable {
    @Attribute(.unique) var externalID: UUID
    @Attribute(.unique) var name: String
    var isHidden: Bool
    var assigned: [MonthYear: Decimal]
    var accountID: UUID
    
    init(
        externalID: UUID,
        name: String,
        isHidden: Bool,
        assigned: [MonthYear : Decimal],
        accountID: UUID
    ) {
        self.externalID = externalID
        self.name = name
        self.isHidden = isHidden
        self.assigned = assigned
        self.accountID = accountID
    }
}
