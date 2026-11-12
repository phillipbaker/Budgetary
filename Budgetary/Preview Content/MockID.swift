//
//  MockID.swift
//  Budgetary
//
//  Created by Phillip Baker on 01/11/2026.
//

import Foundation

extension UUID {
    static func mock(_ id: MockID) -> UUID {
        UUID(uuidString: String(format: "00000000-0000-0000-0000-%012X", id.rawValue))!
    }
}

enum MockID: Int {
    // Budget
    case ukBudget = 1

    // Budget Accounts
    case hsbcChecking = 100
    case barclays
    case hsbcSavings
    case capitalOneCard
    
    // Transfer Payees
    case barclaysTransfer = 200
    case capitalOneCardTransfer
    case hsbcCheckingTransfer
    case hsbcSavingsTransfer
    
    // Regular Payees
    case landlord = 300
    case countyCouncil
    case amazon
    case bigCorporation
    case marksAndSpencer
    case taxi
    case jdSports
    case cleaningService
    case royalAcademyOfDance
    case sportsDirect
    case tesco
    case asda
    case creperie
    case mammaMia
    case aa
    case abeBooks
    case mcDonalds
    case scienceMuseum
    case shell
    case tkMaxx
    case tateBritain
    case thamesWater
    case bodyShop
    case cornishBakery
    case argos
    case origin
    case aviva
    case sixtyFiveMM
    case networkRail
    case waitrose
    case ocado
    case aldi
    case amelia
    case chipotle
    case cineworld
    
    // Category Groups
    case inflow = 400
    case obligations
    case trueExpenses
    case monthlyExpenses
    case fun

    // Categories
    case readyToAssign = 500
    case rent
    case councilTax
    case utilities
    case water
    case internet
    case tvLicense
    case cellPhones
    case birthdays
    case christmas
    case lifeInsurance
    case roadTax
    case carInsurance
    case homeInsurance
    case carServiceRepairs
    case groceries
    case commuting
    case classesCamps
    case petrolTolls
    case homeSupplies
    case homeImprovement
    case kidsClothes
    case gifts
    case doctors
    case amazonPrime
    case prescriptions
    case atmBankFees
    case miscellaneous
    case phil
    case kids
    case school
    case streaming
    case familyActivities
    case takeout
    
    // Transactions
    case sepInflow = 600
    case octInflow
    case octAA
    case novInflow
    case novRent
    case decInflow
}
