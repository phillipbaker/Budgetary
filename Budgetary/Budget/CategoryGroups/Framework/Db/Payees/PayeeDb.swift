//
//  PayeeDb.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

import SwiftData

@Model
final class PayeeDb: Equatable {
    @Attribute(.unique) var id: String
    var name: String
    var aliases: [String]
    var includedInPayeeList: Bool
    var automaticallyCategorizeIsOn: Bool
    var defaultCategoryId: String?
    
    init(
        id: String,
        name: String,
        aliases: [String],
        includedInPayeeList: Bool,
        automaticallyCategorizeIsOn: Bool,
        defaultCategoryId: String?
    ) {
        self.id = id
        self.name = name
        self.aliases = aliases
        self.includedInPayeeList = includedInPayeeList
        self.automaticallyCategorizeIsOn = automaticallyCategorizeIsOn
        self.defaultCategoryId = defaultCategoryId
    }
}
