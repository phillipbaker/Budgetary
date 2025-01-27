//
//  PayeesDbPreviewData.swift
//  Budgetary
//
//  Created by Phillip Baker on 09/12/2024.
//

extension Array where Element == PayeeDb {
    static let mock: [PayeeDb] = [.anthonyMartin, .councilTax, .amazon]
}

extension PayeeDb: @unchecked Sendable {
    static let anthonyMartin = PayeeDb(
        id: "1",
        name: "Anthony Martin",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryId: "1"
    )
    
    static let councilTax = PayeeDb(
        id: "2",
        name: "Council Tax",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryId: "2"
    )
    
    static let amazon = PayeeDb(
        id: "3",
        name: "Amazon",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryId: "3"
    )
    
    static let octus = PayeeDb(
        id: "4",
        name: "Octus",
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: true,
        defaultCategoryId: "4"
    )
}
