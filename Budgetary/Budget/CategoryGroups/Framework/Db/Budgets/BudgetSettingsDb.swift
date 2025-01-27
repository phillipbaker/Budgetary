//
//  BudgetSettingsDb.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

import SwiftData

@Model
final class BudgetSettingsDb: Equatable {
    var name: String
    var curreny: String
    var currencyFormet: String
    var numberFormat: String
    var dateFormat: String
    
    init(
        name: String,
        curreny: String,
        currencyFormet: String,
        numberFormat: String,
        dateFormat: String
    ) {
        self.name = name
        self.curreny = curreny
        self.currencyFormet = currencyFormet
        self.numberFormat = numberFormat
        self.dateFormat = dateFormat
    }
}
