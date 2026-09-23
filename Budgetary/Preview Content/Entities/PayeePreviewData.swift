//
//  PayeePreviewData.swift
//  Budgetary
//
//  Created by Phillip Baker on 19/09/2024.
//

import Foundation

extension Payee {
    static let anthonyMartin = Payee(
        id: .init(),
        name: "Anthony Martin",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategory: .rent
    )
    
    static let amazon = Payee(
        id: .init(),
        name: "Amazon",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategory: .groceries
    )
    
    static let sainsburys = Payee(
        id: .init(),
        name: "Sainsbury’s",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategory: .groceries
    )
    
    static let nyt = Payee(
        id: .init(),
        name: "New York Times",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategory: .cellPhones
    )
    
    static let ikea = Payee(
        id: .init(),
        name: "Ikea",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategory: .rent
    )
    
    static let bexley = Payee(
        id: .init(),
        name: "London Borough of Bexley",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategory: .councilTax
    )
    
    static let eonNext = Payee(
        id: .init(),
        name: "Eon Next",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategory: .utilities
    )
    
    static let thamesWater = Payee(
        id: .init(),
        name: "Thames Water",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategory: .water
    )
    
    static let plusnet = Payee(
        id: .init(),
        name: "Plusnet",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategory: .internet
    )
    
    static let tvLicence = Payee(
        id: .init(),
        name: "TV Licence",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategory: .tvLicense
    )
    
    static let giffGaff = Payee(
        id: .init(),
        name: "Giff Gaff",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategory: .cellPhones
    )
    
    static let reorg = Payee(
        id: .init(),
        name: "Reorg",
        type: .regular,
        aliases: [],
        includedInPayeeList: true,
        automaticallyCategorizeIsOn: false,
        defaultCategory: .readyToAssign
    )
}
