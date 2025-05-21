//
//  TransactionPreviews.swift
//  Budgetary
//
//  Created by Phillip Baker on 19/09/2024.
//

import Foundation

extension Array where Element == TransactionEntity {
    static let preview: [TransactionEntity] = [
        .augSalary,
        .augRent,
        .augCouncilTax,
        .augUtilities,
        .augWater,
        .augGroceries1,
        .augGroceries2,
        .augGroceries3,
        .augGroceries4,
        .augGroceries5,
        .sepSalary,
        .sepRent,
        .sepCouncilTax,
        .sepUtilities,
        .sepWater,
        .sepGroceries1,
        .sepGroceries2,
        .sepGroceries3,
        .sepGroceries4,
        .sepGroceries5,
        .octSalary,
        .octRent,
        .octCouncilTax,
        .octUtilities,
        .octWater,
        .octGroceries1,
        .octGroceries2,
        .octGroceries3,
        .octGroceries4,
        .octGroceries5,
    ].sorted { $0.date < $1.date }
}

extension TransactionEntity {
    // August 2024
    
    static let augSalary = TransactionEntity(
        date: .augEigth2024,
        payee: .reorg,
        category: .readyToAssign,
        amount: .inflow(1000),
        isCleared: true
    )
    
    static let augRent = TransactionEntity(
        date: .augEigth2024,
        payee: .anthonyMartin,
        category: .rent,
        amount: .outflow(100),
        isCleared: true
    )
    
    static let augCouncilTax = TransactionEntity(
        date: .augNinth2024,
        payee: .bexley,
        category: .councilTax,
        amount: .outflow(100),
        isCleared: true
    )
    
    static let augUtilities = TransactionEntity(
        date: .augNinth2024,
        payee: .eonNext,
        category: .utilities,
        amount: .outflow(100),
        isCleared: true
    )
    
    static let augWater = TransactionEntity(
        date: .augTenth2024,
        payee: .thamesWater,
        category: .water,
        amount: .outflow(100),
        isCleared: true
    )
    
    static let augInternet = TransactionEntity(
        date: .augFourteenth2024,
        payee: .plusnet,
        category: .internet,
        amount: .outflow(100),
        isCleared: true
    )
    
    static let augTvLicense = TransactionEntity(
        date: .augTenth2024,
        payee: .tvLicence,
        category: .tvLicense,
        amount: .outflow(100),
        isCleared: true
    )
    
    static let augCellPhones = TransactionEntity(
        date: .augTenth2024,
        payee: .giffGaff,
        category: .cellPhones,
        amount: .outflow(100),
        isCleared: true
    )
    
    static let augGroceries1 = TransactionEntity(
        date: .augEigth2024,
        payee: .sainsburys,
        category: .groceries,
        amount: .outflow(300),
        isCleared: true
    )
    
    static let augGroceries2 = TransactionEntity(
        date: .augEigth2024,
        payee: .sainsburys,
        category: .groceries,
        amount: .outflow(200),
        isCleared: true
    )
    
    static let augGroceries3 = TransactionEntity(
        date: .augTenth2024,
        payee: .sainsburys,
        category: .groceries,
        amount: .outflow(200),
        isCleared: true
    )
    
    static let augGroceries4 = TransactionEntity(
        date: .augFourteenth2024,
        payee: .sainsburys,
        category: .groceries,
        amount: .outflow(100),
        isCleared: true
    )
    
    static let augGroceries5 = TransactionEntity(
        date: .augEigth2024,
        payee: .sainsburys,
        category: .groceries,
        amount: .outflow(100),
        isCleared: true
    )
    
    // September 2024
    
    static let sepSalary = TransactionEntity(
        date: .sepEigth2024,
        payee: .reorg,
        category: .readyToAssign,
        amount: .inflow(1000),
        isCleared: true
    )
    
    static let sepRent = TransactionEntity(
        date: .sepEigth2024,
        payee: .anthonyMartin,
        category: .rent,
        amount: .outflow(100),
        isCleared: true
    )
    
    static let sepCouncilTax = TransactionEntity(
        date: .sepNinth2024,
        payee: .bexley,
        category: .councilTax,
        amount: .outflow(0),
        isCleared: true
    )
    
    static let sepUtilities = TransactionEntity(
        date: .sepNinth2024,
        payee: .eonNext,
        category: .utilities,
        amount: .outflow(100),
        isCleared: true
    )
    
    static let sepWater = TransactionEntity(
        date: .sepTenth2024,
        payee: .thamesWater,
        category: .water,
        amount: .outflow(100),
        isCleared: true
    )
    
    static let sepInternet = TransactionEntity(
        date: .sepFourteenth2024,
        payee: .plusnet,
        category: .internet,
        amount: .outflow(100),
        isCleared: true
    )
    
    static let sepTvLicense = TransactionEntity(
        date: .sepTenth2024,
        payee: .tvLicence,
        category: .tvLicense,
        amount: .outflow(100),
        isCleared: true
    )
    
    static let sepCellPhones = TransactionEntity(
        date: .sepTenth2024,
        payee: .giffGaff,
        category: .cellPhones,
        amount: .outflow(100),
        isCleared: true
    )
    
    static let sepGroceries1 = TransactionEntity(
        date: .sepEigth2024,
        payee: .sainsburys,
        category: .groceries,
        amount: .outflow(100),
        isCleared: true
    )
    
    static let sepGroceries2 = TransactionEntity(
        date: .sepEigth2024,
        payee: .sainsburys,
        category: .groceries,
        amount: .outflow(100),
        isCleared: true
    )
    
    static let sepGroceries3 = TransactionEntity(
        date: .sepTenth2024,
        payee: .sainsburys,
        category: .groceries,
        amount: .outflow(100),
        isCleared: true
    )
    
    static let sepGroceries4 = TransactionEntity(
        date: .sepFourteenth2024,
        payee: .sainsburys,
        category: .groceries,
        amount: .outflow(100),
        isCleared: true
    )
    
    static let sepGroceries5 = TransactionEntity(
        date: .sepEigth2024,
        payee: .sainsburys,
        category: .groceries,
        amount: .outflow(100),
        isCleared: true
    )
    
    // October 2024
    
    static let octSalary = TransactionEntity(
        date: .octEigth2024,
        payee: .reorg,
        category: .readyToAssign,
        amount: .inflow(1000),
        isCleared: true
    )
    
    static let octRent = TransactionEntity(
        date: .octEigth2024,
        payee: .anthonyMartin,
        category: .rent,
        amount: .outflow(100),
        isCleared: true
    )
    
    static let octCouncilTax = TransactionEntity(
        date: .octNinth2024,
        payee: .bexley,
        category: .councilTax,
        amount: .outflow(100),
        isCleared: true
    )
    
    static let octUtilities = TransactionEntity(
        date: .octNinth2024,
        payee: .eonNext,
        category: .utilities,
        amount: .outflow(100),
        isCleared: true
    )
    
    static let octWater = TransactionEntity(
        date: .octTenth2024,
        payee: .thamesWater,
        category: .water,
        amount: .outflow(100),
        isCleared: true
    )
    
    static let octInternet = TransactionEntity(
        date: .octFourteenth2024,
        payee: .plusnet,
        category: .internet,
        amount: .outflow(100),
        isCleared: true
    )
    
    static let octTvLicense = TransactionEntity(
        date: .octTenth2024,
        payee: .tvLicence,
        category: .tvLicense,
        amount: .outflow(100),
        isCleared: true
    )
    
    static let octCellPhones = TransactionEntity(
        date: .octTenth2024,
        payee: .giffGaff,
        category: .cellPhones,
        amount: .outflow(100),
        isCleared: true
    )
    
    static let octGroceries1 = TransactionEntity(
        date: .octEigth2024,
        payee: .sainsburys,
        category: .groceries,
        amount: .outflow(100),
        isCleared: true
    )
    
    static let octGroceries2 = TransactionEntity(
        date: .octEigth2024,
        payee: .sainsburys,
        category: .groceries,
        amount: .outflow(100),
        isCleared: true
    )
    
    static let octGroceries3 = TransactionEntity(
        date: .octTenth2024,
        payee: .sainsburys,
        category: .groceries,
        amount: .outflow(100),
        isCleared: true
    )
    
    static let octGroceries4 = TransactionEntity(
        date: .octFourteenth2024,
        payee: .sainsburys,
        category: .groceries,
        amount: .outflow(100),
        isCleared: true
    )
    
    static let octGroceries5 = TransactionEntity(
        date: .octEigth2024,
        payee: .sainsburys,
        category: .groceries,
        amount: .outflow(100),
        isCleared: true
    )
}

extension TransactionCategory {
    // August 2024
    
    static let readyToAssign = TransactionCategory(
        id: UUID().uuidString,
        name: "Ready to Assign"
    )
    
    static let rent = TransactionCategory(
        id: UUID().uuidString,
        name: "Rent"
    )
    
    static let councilTax = TransactionCategory(
        id: UUID().uuidString,
        name: "Council Tax"
    )
    
    static let utilities = TransactionCategory(
        id: UUID().uuidString,
        name: "Utilities"
    )
    
    static let water = TransactionCategory(
        id: UUID().uuidString,
        name: "Water"
    )
    
    static let internet = TransactionCategory(
        id: UUID().uuidString,
        name: "Internet"
    )

    static let tvLicense = TransactionCategory(
        id: UUID().uuidString,
        name: "TV License"
    )
    
    static let cellPhones = TransactionCategory(
        id: UUID().uuidString,
        name: "Cell Phones"
    )
    
    static let groceries = TransactionCategory(
        id: UUID().uuidString,
        name: "Groceries"
    )
}
