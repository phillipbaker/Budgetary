//
//  PayeeDb.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

import Foundation
import SwiftData

@Model
final class PayeeDb: Equatable {
    @Attribute(.unique) var externalID: UUID
    var name: String
    var type: PayeeTypeDb
    var aliases: [String]
    var includedInPayeeList: Bool
    var automaticallyCategorizeIsOn: Bool
    var defaultCategoryID: UUID?
    var accountID: UUID?
    
    init(
        externalID: UUID,
        name: String,
        type: PayeeTypeDb,
        aliases: [String],
        includedInPayeeList: Bool,
        automaticallyCategorizeIsOn: Bool,
        defaultCategoryID: UUID?,
        accountID: UUID?
    ) {
        self.externalID = externalID
        self.name = name
        self.type = type
        self.aliases = aliases
        self.includedInPayeeList = includedInPayeeList
        self.automaticallyCategorizeIsOn = automaticallyCategorizeIsOn
        self.defaultCategoryID = defaultCategoryID
        self.accountID = accountID
    }
}
